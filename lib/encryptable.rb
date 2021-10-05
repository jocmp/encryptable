# frozen_string_literal: true

require_relative "encryptable/version"

module Encryptable
  class << self
    def included(mod)
      mod.extend(ClassMethods)
    end
  end

  module ClassMethods
    def attr_encrypted(attr_name)
      # Metaprogramming time. Accesses fields with the "_encrypted" suffix.
      # In ActiveRecord, this could be created using a ActiveRecord migration.
      encrypted_attr_name = "#{attr_name}_encrypted"

      # Define the accessor (getter and setter) for the class.
      # For example, this creates the CreditCard#number and CreditCard#number=()
      # methods without depending on an additional declaration. This depends on some base
      # class functionality, specifically modelled after ActiveRecord, that will already have
      # defined the encrypted-suffixed fields at runtime.
      define_method(attr_name) do
        value = send(encrypted_attr_name)
        decrypt(value)
      end

      define_method("#{attr_name}=") do |value|
        send("#{encrypted_attr_name}=", encrypt(value))
      end
    end
  end

  private

  # This is a Base16 conversion and not encryption whatsoever!
  # In a real application this would be replaced with salt, a hashing algo,
  # and other security measures
  def encrypt(value)
    value.unpack("H*").first
  end

  # As above, so below
  def decrypt(value)
    [value].pack("H*")
  end
end
