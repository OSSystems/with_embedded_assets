require File.expand_path(File.dirname(__FILE__)+ '/../test_helper')

class MainModuleTest < ActiveSupport::TestCase
  def teardown
    WithEmbeddedAssets.enabled = false
  end

  test "embedding assets config are local to threads" do
    WithEmbeddedAssets.enabled = false
    thread_embed_assets_config = nil
    Thread.new {
      assert !WithEmbeddedAssets.enabled?
      WithEmbeddedAssets.enabled = true
      thread_embed_assets_config = WithEmbeddedAssets.enabled?
    }.join
    assert !WithEmbeddedAssets.enabled?
    assert thread_embed_assets_config
  end
end
