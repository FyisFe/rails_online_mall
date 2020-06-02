class User < ApplicationRecord
  authenticates_with_sorcery!

  attr_accessor :password, :password_confirmation

  validates_presence_of :email, message: "You must enter your email address!"
  validates_format_of :email, message: "Enter a valid email address!", 
      with: /\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*/,
      if: proc { |user| !user.email.blank? }
  validates :email, uniqueness: true

  validates_presence_of :password, message: "Enter your password!", 
    if: :need_validate_password
  validates_presence_of :password_confirmation, message: "Enter your password!",
    if: :need_validate_password
  validates_confirmation_of :password, message: "Passwords must match",
    if: :need_validate_password
  validates_length_of :password, message: "Passwords must be at least 6 characters!", minimum: 6,
    if: :need_validate_password

    def username
        self.email.split('@').first
    end

  private
  def need_validate_password
    self.new_record? || 
      (!self.password.nil? || !self.password_confirmation.nil?)
  end
end