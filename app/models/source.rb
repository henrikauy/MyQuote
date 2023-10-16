class Source < ApplicationRecord
    has_many :quotes, dependent: :nullify

    def full_name
        [fname, lname].join(' ')
    end


    validate :check_fname
    validate :check_lname
    validate :check_byear

    private

    def check_fname
        if fname.empty?
            errors.add(:base, "first name cannot be blank!")
        end
    end

    def check_lname
        if lname.empty?
            errors.add(:base, "last name cannot be blank!")
        end
    end

    def check_byear
        if byear.empty?
            errors.add(:base, "birth year cannot be blank")
        end
    end
end
