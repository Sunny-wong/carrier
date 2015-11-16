class MobileNumber < ActiveRecord::Base
  belongs_to :mobile_number_section, -> { includes :area_code }, counter_cache: true
  validates_presence_of :mobile_number_section
  validates_uniqueness_of :number
  
  after_initialize :save_mobile_number_section
  
  def self.info number
    record = find_by_number number
    
    record = create_mobile_number(number) unless record
    return unless record
    
    { number: number, carrier:  record.mobile_number_section.carrier, province: record.mobile_number_section.area_code.province,
      city: record.mobile_number_section.area_code.city, code: record.mobile_number_section.area_code.code }
  end
  
  def self.create_mobile_number number
    record = new number: number
    
    # 抓取号码信息
    info = NumInfo::MobileOnLine.new.info number
    unless info && info.present?
      NotFoundMobileNumber.find_or_create_by number: number
      return nil 
    end
    
    unless record.mobile_number_section
      area_code = AreaCode.find_or_create_by province: info[:province], city: info[:city], code: info[:area_code]
      record.build_mobile_number_section(mts: number.to_s[0..6], carrier: info[:carrier], area_code: area_code)
    end
    record.save
    
    record
  end
  
  private
  
  def save_mobile_number_section
    self.mobile_number_section = MobileNumberSection.find_by_mts self.number.to_s[0..6]
  end
end
