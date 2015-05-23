require 'spec_helper'

describe WebYiff::App do
  include Rack::Test::Methods

  let(:app) { WebYiff::App }
  let(:yiff_url) { 'https://e621.net/furry.jpg' }
  let(:yiff) { double(RandomYiff::E621, file_url: yiff_url) }

  describe '#yiff' do
    it 'Does not return flv files' do
      app = WebYiff::App.new!
      allow(RandomYiff::E621).to receive(:new).and_yield(yiff)
      expect(yiff).to receive(:file_ext).exactly(2).times
        .and_return('flv', 'jpg')

      app.send(:yiff)
    end
  end

  describe 'Views' do
    before do
      allow(RandomYiff::E621).to receive(:new).and_return(yiff)
    end

    describe '/random_furry_url' do
      it 'Returns an image url' do
        get '/random_furry_url'
        expect(last_response).to be_ok
        expect(last_response.body).to match(yiff_url)
      end
    end

    describe '/random_furry_porn' do
      it 'Returns html with an image of furry porn' do
        get '/random_furry_porn'
        expect(last_response).to be_ok
        expect(last_response.body).to match(/img src='#{yiff_url}'/)
      end
    end

    describe '/random_furry_ascii' do
      let(:ascii_art) { instance_double(AsciiArt) }

      before do
        allow(AsciiArt).to receive(:new).and_return(ascii_art)
        allow(ascii_art).to receive(:to_ascii_art).and_return('ASCII')
      end

      it 'Returns random furry Ascii' do
        get '/random_furry_ascii'
        expect(last_response).to be_ok
        expect(last_response.body).to match('ASCII')
      end
    end
  end
end
