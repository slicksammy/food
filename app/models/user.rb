require 'uuid_helper'

class User < ActiveRecord::Base
  include UUIDHelper

  has_many :addresses, foreign_key: :user_uuid, primary_key: :uuid
  has_many :stripe_tokens, foreign_key: :user_uuid, primary_key: :uuid

  EMAIL_REGEX = /\A[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}\z/i

  # messages are formatted to what display on the front-end, slightly hacky but not a big deal
  validates :email, presence: { message: "Please enter an email" }, uniqueness: { message: "Email already in use", case_sensitive: false }, format: { with: EMAIL_REGEX, message: "email is not a valid format" }
  validates :first_name, presence: { message: "Please enter a first name" }
  validates :last_name, presence: { message: "Please enter a last name" }
  # validates_length_of :password, minimum: 6, message: "password must be at least 6 characters long", if: :password_changed?

  def self.create_with_password!(attributes, password)
    attributes[:salt] = BCrypt::Engine.generate_salt
    attributes[:encrypted_password] = BCrypt::Engine.hash_secret(password, attributes[:salt])

    User.create(attributes)
  end
end
