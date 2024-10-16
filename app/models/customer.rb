class Customer < ApplicationRecord
    validates :name, presence: true
    def password=(password)
        @password = password
    end
    def get_pass
        @password
    end
    
end
