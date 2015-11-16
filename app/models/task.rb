class Task
  def self.section_task num_section = nil
    ary = %w(133 134 153 180 181 189 145 155 156 185 186 135 136 137 138 139 147 150 151 152 157 158 159 182 183 184 187 188)
    ary.each do |num_section|
      last_mts = MobileNumberSection.where('mts like ?', "#{num_section}%").maximum(:mts)
      middle_num = last_mts ? last_mts[3..6] : '0000'
      
      middle_num.upto('9999').each do |nstr|
        number = num_section.to_s + nstr + '1111'
        MobileNumber.info number.to_i
      end
    end
  end
  
  def self.re_process
    NotFoundMobileNumber.find_each do |re|
      record = MobileNumber.create_mobile_number re.number
      re.delete if record
    end
  end
end 