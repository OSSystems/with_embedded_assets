require File.expand_path(File.dirname(__FILE__)+ '/../test_helper')

class MixinTest < ActiveSupport::TestCase
  include WithEmbeddedAssets::Mixin

  def teardown
    WithEmbeddedAssets.enabled = false
  end

  test "embedding assets with helper method" do
    WithEmbeddedAssets.enabled = false
    expected_css = File.open("#{FIXTURE_PATH}/stylesheets/test_embedded.css", 'r') {|f| f.read }
    result_css = nil
    with_embedded_assets do
      result_css = WithEmbeddedAssets::Processor.new("#{FIXTURE_PATH}/stylesheets/test.css").render
    end
    assert_equal expected_css, result_css
    assert !WithEmbeddedAssets.enabled?
  end

  test "embedding assets with helper method keeps original state" do
    WithEmbeddedAssets.enabled = true
    expected_css = File.open("#{FIXTURE_PATH}/stylesheets/test_embedded.css", 'r') {|f| f.read }
    result_css = nil
    with_embedded_assets do
      result_css = WithEmbeddedAssets::Processor.new("#{FIXTURE_PATH}/stylesheets/test.css").render
    end
    assert_equal expected_css, result_css
    assert WithEmbeddedAssets.enabled?
  end
end
