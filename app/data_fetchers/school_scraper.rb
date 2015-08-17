class SchoolScraper

  attr_reader :html, :type

  def initialize(school_info = {})
    raise ArgumentError.new("You need to pass an url and a type to SchoolScraper #new") if school_info.empty?
    @type = school_info[:type]
    @html = Nokogiri::HTML(open(school_info[:url]))
  end

  def filter_schools
    array = []
    puts "Searching schools..."
    if @type == "cuny"
      @html.css("div.wpb_wrapper p a").each do |title|
        array << School.new(title.text)
      end
    elsif @type == "suny"
      @html.css(".module.purple.page-callout.right ~ table tr td:nth-child(2) a").each do |link|
        array << School.new(link.text)
      end
    else
      raise StandardError.new("Woah! Wrong school type entered")
    end
    array
  end

end
