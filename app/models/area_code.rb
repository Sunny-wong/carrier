class AreaCode < ActiveRecord::Base
  has_many :mobile_number_sections
end
