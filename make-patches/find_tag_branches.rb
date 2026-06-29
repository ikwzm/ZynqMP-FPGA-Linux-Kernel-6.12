#!/usr/bin/env ruby

require 'tmpdir'
require 'open3'
require 'optparse'
require 'set'

options = {
  depth:     64,
  deepen:    64,
  max_depth: 8192,
  verbose:   false,
}

parser = OptionParser.new do |opts|
  opts.banner = <<~USAGE
    Usage:
      #{File.basename($0)} [options] REPOSITORY TAG

    Example:
      #{File.basename($0)} Xilinx/linux-xlnx xlnx_rebase_v6.12_LTS_2025.1_update_merge_6.12.70
  USAGE

  opts.on("-d", "--depth N", Integer,
          "Initial fetch depth (default: #{options[:depth]})") do |v|
    options[:depth] = v
  end

  opts.on("-D", "--deepen N", Integer,
          "Deepen step (default: #{options[:deepen]})") do |v|
    options[:deepen] = v
  end

  opts.on("-m", "--max-depth N", Integer,
          "Maximum fetch depth (default: #{options[:max_depth]})") do |v|
    options[:max_depth] = v
  end

  opts.on("-v", "--verbose", "Verbose output") do
    options[:verbose] = true
  end

  opts.on("-h", "--help", "Show this help") do
    puts opts
    exit
  end
end

begin
  parser.parse!
rescue OptionParser::ParseError => e
  warn e.message
  warn
  warn parser
  exit 1
end

if ARGV.size != 2
  warn parser
  exit 1
end

repo = ARGV[0]
tag  = ARGV[1]

#
# GitHub の owner/repo 形式なら URL に変換
#
repo_url =
  if repo =~ %r{\Ahttps?://} || repo.start_with?("git@")
    repo
  else
    "https://github.com/#{repo}.git"
  end

puts "Repository : #{repo_url}"            if options[:verbose]
puts "Tag        : #{tag}"                 if options[:verbose]
puts "Depth      : #{options[:depth]}"     if options[:verbose]
puts "Deepen     : #{options[:deepen]}"    if options[:verbose]
puts "Max depth  : #{options[:max_depth]}" if options[:verbose]


def run(*cmd)
  stdout, stderr, status = Open3.capture3(*cmd)
  unless status.success?
    raise <<~MSG
      command failed:
      #{cmd.join(' ')}
      #{stderr}
    MSG
  end
  stdout
end

def score(tag, branch)
  branch_parts = branch.split('_').to_set
  tag.split('_').count do |part|
    branch_parts.include?(part)
  end
end

Dir.mktmpdir do |dir|
  Dir.chdir(dir) do

    puts "Initializing repository..."

    run("git", "init", "-q")
    run("git", "remote", "add", "origin", repo_url)

    #
    # タグだけ取得
    #
    puts "Fetching tag #{tag}..."

    run(
      "git", "fetch",
      "--filter=blob:none",
      "origin",
      "tag", tag
    )

    #
    # ブランチ一覧取得
    #
    puts "Getting branch list..."

    branches =
      run("git", "ls-remote", "--heads", "origin")
      .lines
      .map { |l| l.split.last.sub("refs/heads/", "") }

    puts "#{branches.size} branches found."
    puts

    branches.sort_by! { |branch| -score(tag, branch) }

    branches.each do |branch|

      puts "=== #{branch}"

      #
      # 最初だけ shallow fetch
      #
      run(
        "git", "fetch",
        "--depth=#{options[:depth]}",
        "--filter=blob:none",
        "origin",
        "#{branch}:refs/remotes/origin/#{branch}"
      )

      depth = options[:depth]

      loop do

        #
        # ancestor判定
        #
        ok = system(
          "git",
          "merge-base",
          "--is-ancestor",
          "refs/tags/#{tag}",
          "refs/remotes/origin/#{branch}",
          out: File::NULL,
          err: File::NULL
        )

        if ok
          puts "  -> contains #{tag}"
          break
        end

        #
        # もう十分深い
        #
        if depth >= options[:max_depth]
          puts "  -> not found (searched depth=#{depth})"
          break
        end

        #
        # さらに過去を取得
        #
        run(
          "git", "fetch",
          "--deepen=#{options[:deepen]}",
          "--filter=blob:none",
          "origin",
          branch
        )

        depth += options[:deepen]

      end
    end
  end
end

