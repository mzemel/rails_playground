require ::File.expand_path('../config/environment', __FILE__)

require_relative '/Users/mzemel/.rbenv/versions/2.1.2/lib/ruby/gems/2.1.0/gems/ohm-2.2.0/lib/ohm.rb'
Dir['./jobs/**/*.rb'].each { |job| require job }