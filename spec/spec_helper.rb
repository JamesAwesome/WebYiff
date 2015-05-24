ENV['RACK_ENV'] = 'test'

require 'coveralls'
Coveralls.wear!

require_relative '../app'
require 'rack/test'
require 'rspec'
