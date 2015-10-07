require_relative 'test_helper'

class BOMDetectionTest < MiniTest::Test
  include DetencHelper

  SAMPLE = "Pâté: €3.20"

  def test_should_recognise_utf8_with_a_bom
    assert_equal UTF_8, detenc("\xEF\xBB\xBF"+SAMPLE)
  end

  def test_should_recognise_a_utf16LE_bom
    assert_equal UTF_16LE, detenc("\xFF\xFE".force_encoding(UTF_16LE)+SAMPLE.encode(UTF_16LE))
  end

  def test_should_recognise_a_utf16BE_bom
    assert_equal UTF_16BE, detenc("\xFE\xFF".force_encoding(UTF_16BE)+SAMPLE.encode(UTF_16BE))
  end
end
