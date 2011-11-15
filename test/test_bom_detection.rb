require File.join(File.dirname(__FILE__), 'common')

class EncodingDetectionTest < Test::Unit::TestCase
  include DetencHelper

  SAMPLE = "Pâté: €3.20"

  def test_should_recognise_utf8_with_a_bom
    assert_equal UTF_8, detenc("\xEF\xBB\xBF"+SAMPLE)
  end

  def test_should_recognise_a_utf16LE_bom
    assert_equal UTF_16LE, detenc("\xFF\xFE"+Iconv.new(UTF_16LE, UTF_8).iconv(SAMPLE))
  end

  def test_should_recognise_a_utf16BE_bom
    assert_equal UTF_16BE, detenc("\xFE\xFF"+Iconv.new(UTF_16BE, UTF_8).iconv(SAMPLE))
  end
end
