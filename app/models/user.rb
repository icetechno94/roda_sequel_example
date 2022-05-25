# frozen_string_literal: true

# User record
class User < Sequel::Model
  one_to_many :user_roles

  def validate
    super
    errors.add(:email, 'not valid email') if email.match(URI::MailTo::EMAIL_REGEXP).nil?
    errors.add(:email, 'must be unique') if self.class.where(blocked: false, email: email).count.positive? && !blocked
  end
end
