# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{rack-lesscss}
  s.version = "0.2.2"
  s.platform = Gem::Platform::RUBY
  s.date = %q{2010-06-04}
  s.authors = ["Marcin Kulik"]
  s.email = %q{marcin.kulik@gmail.com}
  s.homepage = %q{http://sickill.net}
  s.summary = %q{Rack middleware for compiling lesscss files into css}
  s.files = [ "lib/rack-lesscss.rb", "spec/rack-lesscss-spec.rb" ]
  s.add_dependency "less"
  s.require_path = "lib"
end
