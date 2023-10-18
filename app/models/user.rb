class User < ApplicationRecord
    has_secure_password
    has_many :quotes, dependent: :destroy

    # Email validations including email, confirmation, format and unique
    validates :email, confirmation: true, if: :email_changed?, format: URI::MailTo::EMAIL_REGEXP, uniqueness: true
    validates :email_confirmation, presence: true, if: :email_changed?
    
    # Password validation, checking if password is 6-20 characters long and contains atleast one number and one letter
    validates :password, length: { in: 6..20 }, format: { with: /\A(?=.*[A-Za-z])(?=.*[0-9]).+\z/, message: "^: Password must contain atleast one letter and one number" }, 
        unless: -> { password.blank? }

    # First and Last name validation, checking if name is <30 characters and contains only letters
    validates :fname, length: { maximum: 30, too_long: ": %{count} characters is the maximum allowed in your First Name" }, format: { with: /\A[a-zA-Z]+\z/,
        message: ": First Name only allows letters" }
    validates :lname, length: { maximum: 30, too_long: ": %{count} characters is the maximum allowed in your Lirst Name" }, format: { with: /\A[a-zA-Z]+\z/,
        message: ": Lirst Name only allows letters" }
end
