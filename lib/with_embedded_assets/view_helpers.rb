require "with_embedded_assets/mixin"

# Module that replaces helpers methods used on views to embed assets.
#
# The replaced methods only work if the embedding is enabled. If it is not, the
# behaviour is exactly the same as the original method.
module WithEmbeddedAssets::ViewHelpers
  include ::WithEmbeddedAssets::Mixin

  # Inserts a script tag for Javascript assets.
  #
  # This method return a string containing a script tag with Javascript code
  # processed by the asset pipeline directly embed into it.
  #
  # See the original method documentation {http://api.rubyonrails.org/classes/ActionView/Helpers/AssetTagHelper/JavascriptTagHelpers.html#method-i-javascript_include_tag here}.
  def javascript_include_tag(*sources)
    return super unless WithEmbeddedAssets.enabled?

    options = sources.extract_options!.stringify_keys
    tag_attributes = {:type => "text/javascript"}.merge(options)
    content_tag(:script, nil, tag_attributes, false) do
      assets = Array(sources).collect do |js_asset|
        Rails.application.assets[js_asset.to_s + ".js"].to_s
      end
      raw assets.join("\n")
    end
  end

  # Inserts a link tag for stylesheets assets.
  #
  # This method return a string with a link tag with stylesheet declarations
  # processed by the asset pipeline directly embed into it.
  #
  # See the original method documentation {http://api.rubyonrails.org/classes/ActionView/Helpers/AssetTagHelper/StylesheetTagHelpers.html#method-i-stylesheet_link_tag here}.
  def stylesheet_link_tag(*sources)
    return super unless WithEmbeddedAssets.enabled?

    options = sources.extract_options!.stringify_keys
    tag_attributes = {"media" => "screen", "type" => "text/css"}.merge(options)
    content_tag(:style, nil, tag_attributes, false) do
      assets = Array(sources).collect do |css_asset|
        Rails.application.assets[css_asset.to_s + ".css"].to_s
      end
      raw assets.join("\n")
    end
  end
end
