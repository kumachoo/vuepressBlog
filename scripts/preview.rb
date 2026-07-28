#!/usr/bin/env ruby

require "webrick"

site_root = File.expand_path("../docs/.vuepress/dist", __dir__)
abort("Build output is missing. Run `npm run docs:build` first.") unless File.file?(File.join(site_root, "index.html"))

port = Integer(ENV.fetch("PORT", "8080"))
server = WEBrick::HTTPServer.new(
  BindAddress: "127.0.0.1",
  Port: port,
  DocumentRoot: site_root
)

server.mount(
  "/vuepressBlog",
  WEBrick::HTTPServlet::FileHandler,
  site_root,
  FancyIndexing: false
)

trap("INT") { server.shutdown }
trap("TERM") { server.shutdown }

puts "Preview: http://127.0.0.1:#{port}/vuepressBlog/"
server.start
