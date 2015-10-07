require_relative 'test_helper'

class UnknownEncodingTest < MiniTest::Test
  include DetencHelper

  def test_should_be_unknown_if_it_contains_all_bytes
    sample = (0..0xFF).inject(''){ |s, b|
      s << [b].pack('C')
    }
    assert_equal UNKNOWN, detenc(sample)
  end
end
