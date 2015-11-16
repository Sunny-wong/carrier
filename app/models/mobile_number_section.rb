class MobileNumberSection < ActiveRecord::Base
  validates_uniqueness_of :mts
  belongs_to :area_code
end
