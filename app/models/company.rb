class Company < ApplicationRecord
    has_many :users
    has_many :payrolls
    has_many :periods, through: :payrolls
end
