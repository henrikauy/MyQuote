class Source < ApplicationRecord
    has_many :quotes, dependent: :nullify

    # function to concatenate first and last name of source, seperated by a space
    def full_name
        [fname, lname].join(' ')
    end


    # Custom validations to check first name, last name and birth year of source
    validate :check_fname
    validate :check_lname
    validate :check_byear

    private

    # function giving an error if the first name field is empty
    def check_fname
        if fname.empty?
            errors.add(:base, "first name cannot be blank!") # error message
        end
    end

    # function giving an error if the last name field is empty
    def check_lname
        if lname.empty?
            errors.add(:base, "last name cannot be blank!") # error message
        end
    end

    # function giving an error if the birth year field is empty
    def check_byear
        if byear.empty?
            errors.add(:base, "birth year cannot be blank") # error message
        end
    end
end
