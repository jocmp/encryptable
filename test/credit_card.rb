require "encryptable"

class FakeActiveRecord
  attr_accessor :number_encrypted
end

class CreditCard < FakeActiveRecord
  include Encryptable

  attr_encrypted :number
end
