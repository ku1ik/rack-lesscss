require 'less'

module Rack
  class LessCss
    
    def initialize(app, opts)
      @app = app
      @less_path = opts[:less_path] or raise ArgumentError, "You must specify less_path (path to directory containing .less files)"
      @css_route = opts[:css_route] || "/stylesheets"
      @css_route = @css_route[0..-2] if @css_route[-1] == "/"
    end

    def call(env)
      if env['PATH_INFO'] =~ /#{Regexp.escape(@css_route)}\/([^\.]+)\.css/
        begin
          headers = { 'Content-Type' => 'text/css', 'Cache-Control' => 'private' }
          body = "/* Generated from #{$1}.less by Rack::LessCss middleware */\n\n"
          body << Less::Engine.new(get_source($1)).to_css
          return [200, headers, body]
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