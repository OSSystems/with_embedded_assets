require "with_embedded_assets/version"

# This module handles the activation of embedding assets.
module WithEmbeddedAssets
  class << self
    # Checks if the automatic embedding of assets is active.
    # @return [Boolean] true if the automatic embedding of assets is active, false otherwise
    def enabled
      !!Thread.current[THREAD_VARIABLE_KEY]
    end
    alias :enabled? :enabled

    # Sets the automatic embedding of assets on or off.
    # @param value An object that will be evaluated as true or false by double
    #              negation (!!value).
    def enabled=(value)
      Thread.current[THREAD_VARIABLE_KEY] = !!value
    end
  end

  private
  THREAD_VARIABLE_KEY = :with_embed_assets_enabled
end

require 'with_embedded_assets/railtie' if defined? Rails
