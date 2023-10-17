class Source < ApplicationRecord
    has_many :quotes, dependent: :nullify

    # function to concatenate first and last name of source, seperated by a space
    def full_name
        [fname, lname].join(' ')
    end

    # Custom validation to check first name
    validate :check_fname

    private

    # function giving an error if the first name field is empty
    def check_fname
        if fname.empty?
            errors.add(:base, "first name cannot be blank!") # error message
        end
    end
end
