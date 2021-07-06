# ruby craigslist_gig_scraper.rb
require 'open-uri'
require 'nokogiri'
require 'byebug'

class WebScraper
    def initialize(cities, search_terms)
        @cities = cities
        @search_terms = search_terms
    end

    def scrapper
        @cities.each do |city|
            @search_terms.each do |search_term|
                url = "https://#{city}.craigslist.org/search/sss?query=#{search_term}&is_paid=all"

                document = URI.open(url)
                content = document.read

                parsed_content = Nokogiri::HTML(content)

                puts "==============================="
                puts " "
                puts "  #{city.capitalize} - #{search_term.capitalize}"
                puts " "
                puts "==============================="

                parsed_content.css('.content').css('.result-row').each do |row|
                    title = row.css('.result-title').inner_text
                    posted_at = row.css('time').first.attributes["datetime"].value
                    location = row.css(".result-hood").inner_text.strip
                    link = row.css(".result-title").first.attributes["href"].value

                    if location.length == 0
                        location = row.css(".nearby").inner_text.strip
                    end

                    puts title
                    puts "Posted at #{posted_at}"
                    puts "Location: #{location.capitalize.delete("(").delete(")")}"
                    puts link
                    puts "------------------------------------------"
                end
            end
        end
    end
end