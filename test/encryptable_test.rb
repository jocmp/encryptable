# frozen_string_literal: true

require "test_helper"
require "credit_card"

class EncryptableTest < Minitest::Test
  def test_that_it_encrypts_a_credit_card_number
    expected_number_encrypted = "34313131313131313131313131313131"
    credit_card_number = "4111111111111111"

    credit_card = CreditCard.new
    credit_card.number = credit_card_number

    assert_equal(expected_number_encrypted, credit_card.number_encrypted)
  end
end
