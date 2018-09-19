class JobController < ApplicationController
  def index
    @links.all = Links.all
    @titles.all = Titles.all
  end

  def search
  end

  def craigslist_scrape

    require 'Nokogiri'
    require "open-uri"

    doc = Nokogiri::HTML(open("http://www.eslcafe.com/jobs/korea/").read)
    @titles = doc.search('dd strong')
    @links  = doc.search('dd a').map{|tag|
      case tag.name.downcase
      when 'a'
        tag['href']
      end
    }

    render template: 'job/index'

  end


  # def craigslist_scrape
  #   require 'open-uri'
  #
  #   url = "https://seoul.craigslist.org/search/english"
  #
  #   page = Nokogiri::HTML(open(url))
  #   @links = page.css("li.result-row p.result-info a.result-title.hdrlnk")
  #   @dates = page.css("li.result-row p.result-info time.result-date")
  #   render template: 'job/index'
  # end

end
