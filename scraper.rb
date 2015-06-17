require 'mechanize'

URL = `echo $URL`.sub(/\n/, '')

class Scraper


  def begin
    (252...4000000).each do |id|
      record id
    end
  end

  def record id
    mechanize = Mechanize.new
    page = mechanize.get("#{URL}/#{id}") 
    p "Trying #{id} : #{page.at('.repEmail')}"
    match = /.*<a\s?href=?\"mailto:(.*)">/.match(page.at('.repEmail').to_s)
    puts match 
    text = match[1] if match
    write text, id if text
  end

  def write email, id
    p "Writing #{id} : #{email}"
    File.open("emails.csv", 'a+') {|f| 
      f.write("#{id}, #{email}\n")
    }
  end


end

Scraper.new.begin
