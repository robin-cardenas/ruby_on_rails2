class Employee < ApplicationRecord
  has_many :salaries
  has_many :payrolls
  
  belongs_to :company
end
