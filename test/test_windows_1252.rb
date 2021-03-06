require_relative 'test_helper'

class Windows1252Test < MiniTest::Test
  include DetencHelper

  INVALID_BYTES = (0x00..0x08).to_a + (0x0E..0x1F).to_a + [0x7F, 0x81, 0x8D, 0x8F, 0x90, 0x9D]

  def test_should_be_windows_1252_if_it_contains_all_valid_bytes
    sample = (0..0xFF).inject(''){ |s, b|
      s << [b].pack('C') unless INVALID_BYTES.include?(b)
      s
    }
    assert_equal WINDOWS_1252, detenc(sample)
  end

  def test_should_not_be_windows_1252_if_it_contains_one_invalid_byte
    INVALID_BYTES.each do |invalid_byte|
      sample = (0..0xFF).inject(''){ |s, b|
        s << [b].pack('C') unless (INVALID_BYTES - [invalid_byte]).include?(b)
        s
      }
      refute_equal WINDOWS_1252, detenc(sample), "Byte 0x%02X is not in %s" % [invalid_byte, WINDOWS_1252]
    end
  end
end

