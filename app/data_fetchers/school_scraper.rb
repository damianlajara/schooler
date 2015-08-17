class SchoolScraper

  attr_reader :html#, :suny, :cuny

  def initialize(url)
    @html = Nokogiri::HTML(open(url))
  end

  def filter_schools
    array = []
    puts "Searching schools..."
    @html.css(".module.purple.page-callout.right ~ table tr td:nth-child(2) a").each do |link|
      array << link.text  
    end
    array
  end

end
