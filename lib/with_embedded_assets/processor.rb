require "sprockets/processor"
require 'base64'

# CSS asset processor that embeds images and other files in the code. It
# subclass
# {http://www.rubydoc.info/github/sstephenson/sprockets/master/Sprockets/Processor
# Sprockets::Processor} to achieve this, as a registered Sprockets
# post-processor.
#
# The processor registration on Sprockets is handle by a railtie, on
# {WithEmbeddedAssets::Railtie WithEmbeddedAssets::Railtie}.
#
# This class was written using parts of the embed-assets-rails gem. Please read
# the file under license/embed-assets-rails for the original license. If you
# plan to use or modify it, and then distribute it, please include the license
# file together in the software bundle.
#
# The original source can be found at:
# https://github.com/saulabs/embed-assets-rails
class WithEmbeddedAssets::Processor <  Sprockets::Processor
  # Method called by Sprockets to post-process the CSS code.
  #
  # See the original implementation
  # {http://www.rubydoc.info/github/sstephenson/sprockets/master/Sprockets/Processor#evaluate-instance_method
  # here}.
  def evaluate(context, locals, &block)
    # Use this variable as cache to avoid reprocessing the same asset during
    # this run.
    @encoded_asset_contents = {}

    return data unless WithEmbeddedAssets.enabled?

    # process each CSS asset
    data.gsub(EMBED_DETECTOR) do |url|
      asset = Rails.application.assets[File.basename $1]
      if embeddable?(asset)
        encoded_body = encoded_contents(asset)
        "url(\"data:#{mime_type($1)};charset=utf-8;base64,#{encoded_body}\")"
      else
        "url(#{$1})"
      end
    end
  end

  protected

  # Mapping from extension to mime-type of all embeddable assets.
  EMBED_MIME_TYPES = {
    ".png"  => "image/png",
    ".jpg"  => "image/jpeg",
    ".jpeg" => "image/jpeg",
    ".gif"  => "image/gif",
    ".tif"  => "image/tiff",
    ".tiff" => "image/tiff",
    ".ttf"  => "font/truetype",
    ".otf"  => "font/opentype",
    ".woff" => "font/woff"
  }.freeze

  EMBED_EXTS = EMBED_MIME_TYPES.keys.freeze

  # CSS asset-embedding regexes for URL rewriting.
  EMBED_DETECTOR  = /url\(['"]?([^\s)]+\.[a-z]+)(\?\d+)?['"]?\)/

  def embeddable?(asset)
    asset_path = asset.pathname
    EMBED_EXTS.include?(asset_path.extname)
  end

  # Return the Base64-encoded contents of an asset on a single line.
  def encoded_contents(asset)
    asset_path = asset.pathname.to_s
    if @encoded_asset_contents[asset_path]
      return @encoded_asset_contents[asset_path]
    end
    encoded_data = Base64.encode64(asset.to_s).gsub(/\r\n?|\n/, "")
    return @encoded_asset_contents[asset_path] = encoded_data
  end

  # Grab the mime-type of an asset, by filename.
  def mime_type(asset_path)
    EMBED_MIME_TYPES[File.extname(asset_path)]
  end
end
