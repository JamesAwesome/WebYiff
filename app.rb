require 'asciiart'
require 'random_yiff'
require 'sinatra/base'

module WebYiff
  # Main App
  class App < Sinatra::Application
    get '/random_furry_porn' do
      haml :random_yiff, locals: { yiff_url: yiff.file_url }
    end

    get '/random_furry_ascii' do
      AsciiArt.new(yiff.file_url).to_ascii_art
    end

    get '/random_furry_url' do
      yiff.file_url
    end

    private

    class NotAnImage < StandardError; end

    def yiff
      RandomYiff::E621.new do |yiff|
        fail NotAnImage if yiff.file_ext == 'flv'
      end
    rescue NotAnImage
      yiff
    end
  end
end
