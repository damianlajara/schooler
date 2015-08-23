require "pry"
class SchoolScraper

  attr_reader :html, :type

  def initialize(school_info = {})
    raise ArgumentError.new("You need to pass an url and a type to SchoolScraper #new") if school_info.empty?
    @type = school_info[:type]
    @html = Nokogiri::HTML(open(school_info[:url]))
  end

  def show_loading(message)
    print "\n#{message}"
    4.times do |_|
       print "."
       sleep(1)
     end
     print "\n"
  end

  def read_file
    show_loading "Reading from file for schools"
    schools = []
    school_hash = JSON.parse(File.read("app/lib/#{@type}_school_info.json"))
    school_hash.each.with_index do |(name, info),index|
      #puts index
      next if index == 15 && @type == "cuny"
      school = School.new(name)
      school.website = info["website"].strip
      school.campusview = info["campusview"].strip
      school.address = info["address"].strip
      school.phone_number = info["phone_number"].strip
      schools << school
    end
    schools
  end

  def filter_schools
    array = []
    school_hash = {}
    show_loading "Scraping schools"
    #TODO Find a way to get the total number of schools instead of hardcoding
    schools_total_num = @type == "cuny" ? 23 : 64
    progress = ProgressBar.create( :format => '%a %bᗧ%i %p%% %t',
                    :progress_mark  => ' ',
                    :remainder_mark => '･',
                    :total => schools_total_num)

    if @type == "cuny"
      cuny_school_file = File.open("app/lib/cuny_school_info.json", "w+")
      @html.css("div.wpb_column.vc_column_container.vc_col-sm-4 div.wpb_wrapper p").each_with_index do |paragraph, index|
        #paragraph => "Baruch College\nOne Bernard Baruch Way\nNew York, NY 10010-5585"
        info = paragraph.text.split(/\n/)
        cuny_school = School.new(info.shift)
        link = paragraph.css("a")
        url = link.attribute("href").value

        school_hash[cuny_school.name] = {}

        # There is a special case where the cuny school of public health site: "http://www2.cuny.edu/about/colleges-schools/cuny-school-of-public-health/"
        # simply redirects you to the original site http://sph.cuny.edu/, so no need to scrape it again
        # Keep in mind though, that since it has multiple campuses, there will be no campus view for sph

        # TODO Refactor this
        # if index == 15
        #   cuny_school.website = url
        #   cuny_school.campusview = nil
        #   array << cuny_school
        #   next
        # end

        next if index == 15 # Skip school of public health

        new_site = Nokogiri::HTML(open(url))
        cuny_school.website = new_site.at_css("div.wpb_wrapper a:nth-child(3)").attribute("href").value
        cuny_school.campusview = new_site.at_css("div.wpb_wrapper p a").attribute("href").value
        #binding.pry
        cuny_school.phone_number = new_site.css(".vc_col-sm-8 .vc_align_left+ .box-white p").text.scan(/Phone: (.+\b)/).join
        cuny_school.address = info.join " "
        add_school(cuny_school, school_hash)
        array << cuny_school
        progress.increment
      end
      show_loading "Creating cuny file"
      File.open(cuny_school_file, "w+") { |f| f.write(JSON.generate(school_hash)) }
    elsif @type == "suny"
      suny_school_file = File.open("app/lib/suny_school_info.json", "w+")
      @html.css(".module.purple.page-callout.right ~ table tr td:nth-child(2) a").each do |link|
        suny_school = School.new(link.text)
        url = link.attribute("href").value
        new_site = Nokogiri::HTML(open("#{AllAboutSchools::SUNY_BASE_URL}#{url}"))
        info = new_site.css("div.module.location.blue p").children.map{|x| x.content }.reject {|h| h == ""}
        suny_school.address = info.shift(2).join(" ")
        suny_school.phone_number = info.first
        suny_school.website = info.last
        suny_school.campusview = new_site.at_css("div.module.location.blue a").attribute("href").value
        add_school(suny_school, school_hash)
        array << suny_school
        progress.increment
      end
      show_loading "Creating suny file"
      File.open(suny_school_file, "w+") { |f| f.write(JSON.generate(school_hash)) }
    else
      raise StandardError.new("Woah! Error scraping schools")
    end
    puts array.count
    array
  end
  def add_school(school, school_hash)
    school_hash[school.name][:website] = school.website
    school_hash[school.name][:campusview] = school.campusview
    school_hash[school.name][:phone_number] = school.phone_number
    school_hash[school.name][:address] = school.address
  end
end
