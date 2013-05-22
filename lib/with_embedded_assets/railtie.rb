module WithEmbeddedAssets
  # Contains the gem integration code to add the functionality to Rails.
  class Railtie < Rails::Railtie
    require "with_embedded_assets/processor"
    initializer "with_embed_assets.sprockets_postprocessor_setup", :after => 'sprockets.environment' do |app|
      Rails.application.assets.register_postprocessor "text/css", ::WithEmbeddedAssets::Processor
    end

    require "with_embedded_assets/mixin"
    initializer "with_embed_assets.mixin_setup" do |app|
      ::ActionController::Base.send(:include, ::WithEmbeddedAssets::Mixin)
    end

    require "with_embedded_assets/view_helpers"
    initializer "with_embed_assets.view_helper_setup" do |app|
      ::ActionView::Base.send :include, ::WithEmbeddedAssets::ViewHelpers
    end
  end
end
