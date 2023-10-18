class Source < ApplicationRecord
    has_many :quotes, dependent: :nullify

    # function to concatenate first and last name of source, seperated by a space
    def full_name
        [fname, lname].join(' ')
    end

    # First name validation, checking if present, max length, and only letters
    validates :fname, presence: { message: ": First Name can't be blank" },
        length: { maximum: 30, too_long: ": %{count} characters is the maximum allowed for the source's First Name" },
        format: { with: /\A[a-zA-Z]+\z/, message: ": First Name only allows letters" }

    # Last name validation, checking max length, and only letters
    validates :lname, length: { maximum: 30, too_long: ": %{count} characters is the maximum allowed in the source's Last Name" },
        format: { with: /\A[a-zA-Z]+\z/, message: ": Last Name only allows letters" }, allow_blank: true

    # Birth and Death year validations, checking if year is valid
    validates :byear, format: { with: /\A(\d+|\d+\s*BC)\z/, message: ": Birth Year must be a valid year or a valid year in BC" }, allow_blank: true
    validates :dyear, format: { with: /\A(\d+|\d+\s*BC)\z/, message: ": Death Year must be a valid year or a valid year in BC" }, allow_blank: true

    # Bio validation, checking if the bio is too long
    validates :bio, length: { maximum: 500, too_long: ": %{count} characters is the maximum allowed for a biography" }, allow_blank: true
end
