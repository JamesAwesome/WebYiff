ENV['RACK_ENV'] = 'test'

require_relative '../app'
require 'coveralls'
require 'rack/test'
require 'rspec'

Coveralls.wear!
