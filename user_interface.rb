require_relative 'scraper'

class UserInterface
    def initialize
        @scraper = WebScraper.new("","")
    end

    def run
        puts "Hi there, what are you looking for?"
        search_terms = gets.chomp
        system("clear")
        puts "Thinking...."
        sleep(2)
        system("clear")
        puts "What cities would you like to search?"
        cities = gets.chomp
        system("clear")
        sleep(1)
        @scraper = WebScraper.new([cities],[search_terms])
        p @scraper.scrapper
    end
end

scrapper = UserInterface.new
scrapper.run