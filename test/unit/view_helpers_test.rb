require File.expand_path(File.dirname(__FILE__)+ '/../test_helper')

class ViewHelpersTest < ActionView::TestCase
  include WithEmbeddedAssets::ViewHelpers

  def teardown
    WithEmbeddedAssets.enabled = false
  end

  test "javascript_include_tag with embedding enabled" do
    WithEmbeddedAssets.enabled = true
    expected_result = "<script type=\"text/javascript\">" +
      File.open("#{FIXTURE_PATH}/javascripts/test.js", 'r') {|f| f.read } +
    ";\n</script>"
    assert_equal expected_result, javascript_include_tag(:test)
  end

  test "javascript_include_tag with embedding enabled passing parameters" do
    WithEmbeddedAssets.enabled = true
    expected_result = "<script data-test=\"foobar\" type=\"text/javascript\">" +
      File.open("#{FIXTURE_PATH}/javascripts/test.js", 'r') {|f| f.read } +
    ";\n</script>"
    assert_equal expected_result, javascript_include_tag(:test, :"data-test" => "foobar")
  end

  test "javascript_include_tag with multiple assets and embedding enabled" do
    WithEmbeddedAssets.enabled = true
    expected_result = "<script type=\"text/javascript\">" +
      File.open("#{FIXTURE_PATH}/javascripts/test.js", 'r') {|f| f.read } +
      ";\n\n" +
      File.open("#{FIXTURE_PATH}/javascripts/another_test.js", 'r') {|f| f.read } +
    "</script>"
    assert_equal expected_result, javascript_include_tag(:test, :another_test)
  end

  test "javascript_include_tag with embedding disabled" do
    WithEmbeddedAssets.enabled = false
    expected_result = "<script src=\"/javascripts/test.js\" type=\"text/javascript\"></script>"
    assert_equal expected_result, javascript_include_tag("test")
  end

  test "stylesheet_link_tag with embedding enabled" do
    WithEmbeddedAssets.enabled = true
    expected_result = "<style media=\"screen\" type=\"text/css\">" +
      File.open("#{FIXTURE_PATH}/stylesheets/test_embedded.css", 'r') {|f| f.read } +
    "</style>"
    assert_equal expected_result, stylesheet_link_tag(:test)
  end

  test "stylesheet_link_tag with embedding enabled passing parameters" do
    WithEmbeddedAssets.enabled = true
    expected_result = "<style media=\"print\" type=\"text/css\">" +
      File.open("#{FIXTURE_PATH}/stylesheets/test_embedded.css", 'r') {|f| f.read } +
    "</style>"
    assert_equal expected_result, stylesheet_link_tag(:test, :media => "print")
  end

  test "stylesheet_link_tag with multiple assets and embedding enabled" do
    WithEmbeddedAssets.enabled = true
    expected_result = "<style media=\"screen\" type=\"text/css\">" +
      File.open("#{FIXTURE_PATH}/stylesheets/test_embedded.css", 'r') {|f| f.read } +
      "\n" +
      File.open("#{FIXTURE_PATH}/stylesheets/simple.css", 'r') {|f| f.read } +
    "</style>"
    assert_equal expected_result, stylesheet_link_tag(:test, :simple)
  end

  test "stylesheet_link_tag with embedding disabled" do
    WithEmbeddedAssets.enabled = false
    expected_result = "<link href=\"/stylesheets/test.css\" media=\"screen\" rel=\"stylesheet\" type=\"text/css\" />"
    assert_equal expected_result, stylesheet_link_tag("test")
  end
end
