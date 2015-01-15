require 'open-uri'
require 'nokogiri'
require 'pp'
require "selenium-webdriver"

doc = Nokogiri::HTML(open("http://wo.yao.cl/htm_data/7/1501/1341347.html"), nil, 'UTF-8')
as =doc.xpath("//a")
browser = Selenium::WebDriver.for :firefox

links = []
as.each do |a|
#     pp a.to_s
    links << a.content
    links = links.select { |str| str.include? 'rmdown'}

end

links.each do |link|
    begin
        Timeout::timeout(10) do
            browser.get link
#             browser.find_element(value: "download").click
            body = browser.find_element(:tag_name => 'body')
            body.send_keys(:control, 't')
#             if browser.find_element(id: "once") == nil
#                 print "no 302"
#             end
#             sleep 5
#             browser.close
        end
    rescue
        print "timeout"
    end
end

