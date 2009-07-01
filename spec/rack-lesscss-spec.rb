require 'rubygems'
require 'spec'
require 'rack/builder'
require 'rack/mock'
require File.join(File.dirname(__FILE__), '..', 'lib', 'rack-lesscss.rb')

class Rack::LessCss
  private
  def get_source(stylesheet)
    <<EOF
    #body.#{stylesheet} {
      color: black;
      p {
        margin-bottom: 10px;
        span {
          font-weight: bold;
        }
      }
    }
EOF
  end
end

describe "Rack::LessCss" do
  it "should raise if less_path not given" do
    app = Rack::Builder.new do
      use Rack::LessCss
      run lambda { |env| [404, { 'Content-Type' => 'text/plain' }, ["Not found"]] }
    end
    lambda do
      Rack::MockRequest.new(app).get('/stylesheets/jola.css')
    end.should raise_error(ArgumentError)
  end
  
  it "should successfully convert less to css (with default css route)" do
    app = Rack::Builder.new do
      use Rack::LessCss, :less_path => "/some/path/to/less/files"
      run lambda { |env| [404, { 'Content-Type' => 'text/plain' }, ["Not found"]] }
    end
    response = Rack::MockRequest.new(app).get('/stylesheets/jola.css')
    response.status.should == 200
    response.body.should include("#body.jola")
  end
  
  it "should successfully convert less to css (with custom css route)" do
    app = Rack::Builder.new do
      use Rack::LessCss, :less_path => "/some/path/to/less/files", :css_route => "/css"
      run lambda { |env| [404, { 'Content-Type' => 'text/plain' }, ["Not found"]] }
    end
    response = Rack::MockRequest.new(app).get('/css/misio.css')
    response.status.should == 200
    response.body.should include("#body.misio")
  end
  
  it "should not intercept request for non-matching request path" do
    app = Rack::Builder.new do
      use Rack::LessCss, :less_path => "/some/path/to/less/files", :css_route => "/css"
      run lambda { |env| [404, { 'Content-Type' => 'text/plain' }, ["Not found"]] }
    end
    response = Rack::MockRequest.new(app).get('/stylesheets/jola.css')
    response.status.should == 404
  end
end
