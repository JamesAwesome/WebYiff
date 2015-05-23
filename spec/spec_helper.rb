ENV['RACK_ENV'] = 'test'

require_relative '../app'
require 'rack/test'
require 'rspec'
