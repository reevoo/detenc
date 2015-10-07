require_relative 'test_helper'

class EncodingDetectionTest < MiniTest::Test
  include DetencHelper

  SAMPLE = "Pâté: €3.20"

  def test_should_recognise_utf8
    sample = SAMPLE
    encoding = UTF_8
    assert_equal encoding, detenc(sample)
  end

  def test_should_recognise_windows_1252
    encoding = WINDOWS_1252
    sample = SAMPLE.encode(encoding)
    assert_equal encoding, detenc(sample)
  end

  def test_should_recognise_iso_8859_15
    encoding = ISO_8859_15
    sample = SAMPLE.encode(encoding)
    assert_equal encoding, detenc(sample)
  end

  def test_should_be_us_ascii_if_empty
    assert_equal US_ASCII, detenc('')
  end
end

