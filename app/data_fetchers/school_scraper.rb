require "pry"
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
      @html.css("div.wpb_column.vc_column_container.vc_col-sm-4 div.wpb_wrapper p").each_with_index do |paragraph, index|
        #paragraph => "Baruch College\nOne Bernard Baruch Way\nNew York, NY 10010-5585"
        info = paragraph.text.split(/\n/)
        cuny_school = School.new(info.shift)
        cuny_school.address = info.join " "
        link = paragraph.css("a")
        url = link.attribute("href").value
        # There is a special case where the cuny school of public health site: "http://www2.cuny.edu/about/colleges-schools/cuny-school-of-public-health/"
        # simply redirects you to the original site http://sph.cuny.edu/, so no need to scrape it again
        # Keep in mind though, that since it has multiple campuses, there will be no campus view for sph

        # TODO Refactor this
        if index == 15
          cuny_school.website = url
          cuny_school.campusview = nil
          array << cuny_school
          next
        end

        new_site = Nokogiri::HTML(open(url))
        cuny_school.website = new_site.at_css("div.wpb_wrapper a:nth-child(3)").attribute("href").value
        cuny_school.campusview = new_site.at_css("div.wpb_wrapper p a").attribute("href").value
        array << cuny_school
      end
    elsif @type == "suny"
      @html.css(".module.purple.page-callout.right ~ table tr td:nth-child(2) a").each do |link|
        suny_school = School.new(link.text)
        link.attribute("href").value
        new_site = Nokogiri::HTML(open("#{AllAboutSchools::SUNY_BASE_URL}#{link.attribute("href").value}"))
        info = new_site.css("div.module.location.blue p").children.map{|x| x.content }.reject {|h| h == ""}
        suny_school.address = info.shift(2).join(" ")
        suny_school.phone_number = info.first
        suny_school.website = info.last
        suny_school.campusview = new_site.at_css("div.module.location.blue a").attribute("href").value
        array << suny_school
      end
    else
      raise StandardError.new("Woah! Wrong school type entered")
    end
    array
  end
end
