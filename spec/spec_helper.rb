require 'sinatra'
require 'sinatra/asset_pipeline'
require 'sinatra/asset_pipeline/task'

require 'rack/test'

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = [:should, :expect]
  end
end

class App < Padrino::Base
  set :assets_prefix, %w(assets)
  register Padrino::AssetPipeline
end

class CustomApp < Padrino::Base
  set :assets_prefix, %w(assets, foo/bar)
  set :assets_precompile, %w(foo.css foo.js)
  set :assets_host, 'foo.cloudfront.net'
  set :assets_protocol, :https
  set :environment, :production
  set :assets_css_compressor, :sass
  set :assets_js_compressor, :uglifier
  set :path_prefix, "/static"
  set :assets_debug, true
  register Padrino::AssetPipeline
end

class PrefixApp < Padrino::Base
  set :assets_prefix, %w(assets)
  set :path_prefix, "/static"
  register Padrino::AssetPipeline
end

shared_context "assets" do
  let(:js_content) do
<<eos
(function() {
  (function() {});

}).call(this);
eos
  end

  let(:css_content) do
<<eos
html, body {
  margin: 0;
  padding: 0; }
eos
  end
end
