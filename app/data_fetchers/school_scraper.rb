class SchoolScraper

  attr_reader :html

  def initialize(url)
    @html = Nokogiri::HTML(open(url))
  end

  def filter_schools
    puts "Searching schools..."
    # tweets = html.search("p.tweet-text").collect { |p| p.text }
    # tweets.each_with_object([]) do |tweet, result|
    #   result << School.new(tweet)
    # end
  end

end
