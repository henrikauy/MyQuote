class Source < ApplicationRecord
    has_many :quotes, dependent: :nullify

    def full_name
        [fname, lname].join(' ')
    end

end
