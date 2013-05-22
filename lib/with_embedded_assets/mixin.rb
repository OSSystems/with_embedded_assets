# This mixin declares the method that can be used to temporarily set embedded
# assets in a HTML compiled by ActionView on Rails.
module WithEmbeddedAssets::Mixin
  # Activates the embedding of assets during the execution of a block.
  #
  # After the block finishes the state of the automatic embedding is returned to
  # its previous state before the method was called.
  # @param block The block to be executed with automatic embedding activated.
  # @return [Object] The returned object of the block.
  def with_embedded_assets
    previous_state = WithEmbeddedAssets.enabled?
    WithEmbeddedAssets.enabled = true
    return_value = nil
    begin
      return_value = yield
    ensure
      WithEmbeddedAssets.enabled = previous_state
    end
    return_value
  end
end
