#!/usr/bin/env ruby

require "date"
require "fileutils"
require "json"
require "nokogiri"
require "open3"

SOURCE_BRANCH = "gh-pages"
SITE_BASE = "/vuepressBlog/"
POSTS_ROOT = File.join("docs", "blogs")
PUBLIC_ROOT = File.join("docs", ".vuepress", "public")

STICKY_POSTS = {
  "blogs/专利/patent.html" => 0,
  "blogs/技术/vue-dynamic-router.html" => 2,
  "blogs/技术/2024-我开源了个小工具-simple-maker.html" => 2,
  "blogs/随笔/annual-summary-2021.html" => 0,
  "blogs/随笔/annual-summary-2022.html" => 0,
  "blogs/随笔/annual-summary-2023.html" => 0,
  "blogs/随笔/记录游戏.html" => 4
}.freeze

STATIC_FILES = %w[
  avatar.png
  favicon.ico
  hero.png
  logo.png
].freeze

def git(*arguments)
  output, error, status = Open3.capture3("git", *arguments)
  abort(error) unless status.success?
  output
end

def quote(value)
  JSON.generate(value)
end

def category_for(relative_path)
  section = relative_path.split("/")[1]

  case section
  when "专利"
    "专利"
  when "技术"
    relative_path.end_with?("/红宝书.html") ? "阅读" : "框架"
  when "人物传", "随笔"
    "随笔"
  end
end

def normalized_date(text)
  return if text.nil? || text.strip.empty?

  Date.strptime(text.strip, "%m/%d/%Y").iso8601
rescue Date::Error
  text.strip
end

def frontmatter(title:, date:, category:, tags:, sticky:)
  lines = ["---", "title: #{quote(title)}"]
  lines << "date: #{date}" if date
  lines << "categories: #{quote(category)}" if category
  unless tags.empty?
    lines << "tags:"
    tags.each { |tag| lines << "  - #{quote(tag)}" }
  end
  lines << "sticky: #{sticky}" unless sticky.nil?
  lines << "recoveredFrom: #{quote(SOURCE_BRANCH)}"
  lines << "---"
  lines.join("\n")
end

tree = git("-c", "core.quotepath=false", "ls-tree", "-r", "--name-only", SOURCE_BRANCH)
post_paths = tree.lines(chomp: true)
                 .grep(%r{\Ablogs/.+\.html\z})
                 .reject { |path| path == "blogs/template.html" }

blob_paths = Hash.new { |hash, key| hash[key] = [] }
git("-c", "core.quotepath=false", "ls-tree", "-r", SOURCE_BRANCH, "img", "assets/img")
  .lines(chomp: true)
  .each do |line|
    _mode, _type, object_and_path = line.split(" ", 3)
    object_id, path = object_and_path.split("\t", 2)
    blob_paths[object_id] << path
  end

asset_replacements = {}
blob_paths.each_value do |paths|
  public_path = paths.select { |path| path.start_with?("img/") }.sort.first
  next unless public_path

  paths.grep(%r{\Aassets/img/}).each do |asset_path|
    asset_replacements["#{SITE_BASE}#{asset_path}"] = "#{SITE_BASE}#{public_path}"
  end
end

recovered_posts = []
post_paths.each do |source_path|
  document = Nokogiri::HTML(git("show", "#{SOURCE_BRANCH}:#{source_path}"))
  content = document.at_css(".theme-reco-content.content__default")
  abort("Could not locate article content in #{source_path}") unless content

  content.css("a.header-anchor").remove
  content.css("svg.icon.outbound, span.sr-only").remove
  content.traverse do |node|
    next unless node.element?

    node.attribute_nodes
        .select { |attribute| attribute.name.start_with?("data-v-") }
        .each(&:remove)
  end

  body = content.inner_html.strip
  asset_replacements.each { |from, to| body.gsub!(from, to) }

  title = document.at_css(".page-title h1.title")&.text&.strip
  title = File.basename(source_path, ".html") if title.nil? || title.empty?

  date = normalized_date(document.at_css(".page-title .reco-date span")&.text)
  tags = document.css(".page-title .tags .tag-item").map { |node| node.text.strip }.reject(&:empty?)
  category = category_for(source_path)
  sticky = STICKY_POSTS[source_path]

  relative_output = source_path.delete_prefix("blogs/").sub(/\.html\z/, ".md")
  output_path = File.join(POSTS_ROOT, relative_output)
  FileUtils.mkdir_p(File.dirname(output_path))
  File.write(
    output_path,
    "#{frontmatter(title: title, date: date, category: category, tags: tags, sticky: sticky)}\n\n#{body}\n"
  )
  recovered_posts << output_path
end

public_paths = tree.lines(chomp: true).grep(%r{\Aimg/})
public_paths.concat(STATIC_FILES.select { |path| tree.lines(chomp: true).include?(path) })
public_paths.each do |source_path|
  output_path = File.join(PUBLIC_ROOT, source_path)
  FileUtils.mkdir_p(File.dirname(output_path))
  File.binwrite(output_path, git("show", "#{SOURCE_BRANCH}:#{source_path}"))
end

puts "Recovered #{recovered_posts.length} posts into #{POSTS_ROOT}"
puts "Recovered #{public_paths.length} public assets into #{PUBLIC_ROOT}"
