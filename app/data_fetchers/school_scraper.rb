class SchoolScraper

  attr_reader :html#, :suny, :cuny

  def initialize(url)
    @html = Nokogiri::HTML(open(url))
  end

  def filter_schools
    array = []
    puts "Searching schools..."
<<<<<<< HEAD
    html = Nokogiri::HTML(open(url)).css("div.wpb_wrapper p a"). each do |title|
      puts title.text
    end
    # tweets = html.search("p.tweet-text").collect { |p| p.text }
    # tweets.each_with_object([]) do |tweet, result|



































































































































































    #   result << School.new(tweet)
    # end
=======
    @html.css(".module.purple.page-callout.right ~ table tr td:nth-child(2) a").each do |link|
      array << link.text  
    end
    array
>>>>>>> 9bb829d008c5e8b4d3edee52cd49ef22abad9f62
  end

end
