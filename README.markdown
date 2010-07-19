Rack::LessCss
=============

About
-----

Rack::LessCss, is a Rack middleware which converts .less files into .css files on the fly during request. It’s main purpose is to ease development stage when you change your .less files frequently. With rack-lesscss middleware enabled you don’t need to compile .less files by hand after every change. LessCSS compiler has an option to watch for changes in .less file and automatically recompiles it but you need to remember to run compiler in watch mode for every stylesheet every time you start development session. There are also at least two Rails plugins which nicely integrates LessCSS into the app but this middleware can be used with Rails as well as with other ruby web frameworks like Merb or Sinatra.

Instalation
-----------

<pre><code>gem install rack-lesscss</code></pre>

Usage
-----

Enable in Merb:

<em>config/dependencies.rb</em>:

<pre><code>dependency "rack-lesscss"</code></pre>

<em>config/rack.rb</em> (before line with <code>run Merb::Rack::Application.new</code>):

<pre><code>use Rack::LessCss, :less_path => File.join(Merb.root, "public", "less")</code></pre>

Enable in Rails:

<em>config/environment.rb</em>:

<pre><code>config.gem "rack-lesscss"
config.middleware.use "Rack::LessCss", :less_path => File.join(RAILS_ROOT, "public", "less")
</code></pre>

If you want this middleware to handle stylesheets under other request path you can change it like this:

<pre><code>use Rack::LessCss, :less_path => File.join(Merb.root, "public", "less"), :css_route => "/assets/css"</code></pre>

Contact & Information
---------------------

Marcin Kulik - http://sickill.net/

