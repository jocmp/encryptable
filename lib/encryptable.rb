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

      # Define the getter for the subclass. The defined getter assumes
      # that the underlying value can be decrypted by the algorithm in the
      # private "decrypt" method.
      define_method(attr_name) do
        value = send(encrypted_attr_name)
        decrypt(value)
      end

      # The defined setter always encrypts the value before assigning
      # the encrypted field. In Rails specifically, assignment occurs
      # before an ActiveRecord column update.
      define_method("#{attr_name}=") do |value|
        send("#{encrypted_attr_name}=", encrypt(value))
      end
    end
  end

  private

  # This is a hexadecimal conversion and not encryption whatsoever!
  # In a real application this would be replaced with salt,
  # a hashing algorithm, and other security measures
  def encrypt(value)
    value.unpack("H*").first
  end

  # As above, so below
  def decrypt(value)
    [value].pack("H*")
  end
end
