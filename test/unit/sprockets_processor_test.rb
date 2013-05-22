require File.expand_path(File.dirname(__FILE__)+ '/../test_helper')

class SprocketsProcessorTest < ActiveSupport::TestCase
  def teardown
    WithEmbeddedAssets.enabled = false
  end

  test "embedding assets" do
    WithEmbeddedAssets.enabled = true
    expected_css = File.open("#{FIXTURE_PATH}/stylesheets/test_embedded.css", 'r') {|f| f.read }
    result_css = WithEmbeddedAssets::Processor.new("#{FIXTURE_PATH}/stylesheets/test.css").render
    assert_equal expected_css, result_css
  end

  test "embedding assets disabled" do
    WithEmbeddedAssets.enabled = false
    expected_css = File.open("#{FIXTURE_PATH}/stylesheets/test.css", 'r') {|f| f.read }
    result_css = WithEmbeddedAssets::Processor.new("#{FIXTURE_PATH}/stylesheets/test.css").render
    assert_equal expected_css, result_css
  end
end
