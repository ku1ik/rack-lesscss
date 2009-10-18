require 'less'

module Rack
  class LessCss
    
    def initialize(app, opts)
      @app = app
      @less_path = opts[:less_path] or raise ArgumentError, "You must specify less_path (path to directory containing .less files)"
      css_route = opts[:css_route] || "/stylesheets"
      css_route = css_route[0..-2] if css_route[-1] == "/"
      @css_route_regexp = /#{Regexp.escape(css_route)}\/([^\.]+)\.css/
    end

    def call(env)
      if env['PATH_INFO'] =~ @css_route_regexp
        begin
          headers = { 'Content-Type' => 'text/css', 'Cache-Control' => 'private' }
          body = "/* Generated from #{$1}.less by Rack::LessCss middleware */\n\n"
          body << Less::Engine.new(get_source($1)).to_css
          headers["Content-Length"] = body.size.to_s
          return [200, headers, [body]]
        rescue SyntaxError, StandardError => e
          puts "Rack::LessCss Error: #{e.message}"
        end
      end
      @app.call(env)
    end
    
    private
    def get_source(stylesheet)
      ::File.read(::File.join(@less_path, stylesheet + ".less"))
    rescue
      nil
    end

  end
end
