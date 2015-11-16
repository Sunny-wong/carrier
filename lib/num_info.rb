require 'capybara'
require 'capybara/poltergeist'

module NumInfo
  # 手机在线
  class MobileOnLine
    API_URL = 'http://www.showji.com/search.htm?m='
    attr_accessor :count_retry
    
    def initialize
      @count_retry = 0
      Capybara.default_max_wait_time = 10
    end
  
    def info call_no
      begin
        data = nil
        session = Capybara::Session.new(:poltergeist)
        url = API_URL + call_no.to_s
        session.visit url
        
        unless session.find(:id, 'txtProvince').text.blank?
          data = {
            province:   session.find(:id, 'txtProvince').text,
            city:       session.find(:id, 'txtCity').text,
            area_code:  session.find(:id, 'txtAreaCode').text,
            post_code:  session.find(:id, 'txtPostCode').text,
            carrier:    session.find(:id, 'txtTO').text
          }
        end
      rescue => e
        log = Logger.new 'log/number_info'
        log.error e.message
        
        if @count_retry < 3 && e.exception.is_a?(Capybara::Poltergeist::TimeoutError)
          session.driver.quit
          sleep 3 && @count_retry += 1 && retry 
        end
      ensure
        session.driver.quit
        return data 
      end
    end
  end
  
  # 腾讯API
end
