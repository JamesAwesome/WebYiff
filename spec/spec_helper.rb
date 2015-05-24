ENV['RACK_ENV'] = 'test'

require 'coveralls'
require_relative '../app'
require 'rack/test'
require 'rspec'

Coveralls.wear!
