require 'helper'

class TestSwfutil < Test::Unit::TestCase
  should "take the filename as a mandatory parameter" do
    assert_nothing_raised do
      swiff = Swiff.new fixture_path('clicktag.swf')
    end
  end

  context "a file" do
    setup do
      @swiff = Swiff.new fixture_path('clicktag.swf')
    end

    should "be able to determine whether it is compressed" do
      assert_equal true, @swiff.is_compressed?
    end

    should "be able to determine whether it is not compressed" do
      @swiff = Swiff.new fixture_path('clicktag-decompressed.swf')
      assert_equal false, @swiff.is_compressed?
    end

    should "be able to determine file is a swf" do
      assert_equal true, @swiff.is_swf?

      @not_swiff = Swiff.new fixture_path('smallgoat.jpg')

      assert_equal false, @not_swiff.is_swf?
    end

  end
end
