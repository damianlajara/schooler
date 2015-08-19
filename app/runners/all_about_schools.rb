class AllAboutSchools
  SUNY_BASE_URL = "http://www.suny.edu"

  def call
    puts "*~*~* Welcome to EyeSpy V1.0 Campus Edition! *~*~*"
    help
    run
  end

  def get_user_input
    gets.chomp.strip
  end

  def run
    print "Awaiting Input: "
    input = get_user_input.downcase
    if input == "help"
      help
    elsif input == "exit"
      exit
    elsif input == "c" || input == "cuny"
      process_cuny_schools
    elsif input == "s" || input == "suny"
      process_suny_schools
    else
      puts "Error! That command is invalid! Please try again."
    end
    run
  end

  def display(school)
    school.each.with_index {|school,index| puts "#{index.next}. #{school.name}\n    #{school.address}\n    #{school.phone_number}\n    #{school.website}"}
  end
  #File.open("../lib/school_info.json", 'w') {|f| f.write(JSON.parse(hash)) }

  # if File.exist?("../temp.json")
  #   @array << JSON.parse(File.read("../lib/school_info.json"))
  # else
  # 		File.write("../lib/school_info.json", @array.to_json)
  # end

  def process_cuny_schools
    cuny_saved = File.exist?("app/lib/cuny_school_info.json")
    url = "http://www2.cuny.edu/about/colleges-schools/"
    school_scraper = SchoolScraper.new(url: url, type: "cuny")
    schools = parse_schools(school_scraper, cuny_saved)
    puts "Found your cuny schools!"
    display schools
    view_map_selector schools
  end

  def parse_schools(schools, saved)
    saved ? schools.read_file : schools.filter_schools
  end

  def process_suny_schools
    suny_saved = File.exist?("app/lib/suny_school_info.json") ? true : false
    url = "#{SUNY_BASE_URL}/attend/visit-us/complete-campus-list/"
    school_scraper = SchoolScraper.new(url: url, type: "suny")
    schools = parse_schools(school_scraper, suny_saved)
    puts "Found your suny schools!"
    display schools
    view_map_selector schools
  end

  def view_map_selector(schools)
    print "Would you like to see a school? (Y)es or (N)o: "
    input = get_user_input.downcase
      if input == "y" || input == "yes"
        print "Select a number: "
        number = get_user_input.to_i
        open_campus_view schools[number.pred]
      elsif input == "n" || input == "no"
        puts "Aww man. The campus viewer is pretty cool!"
        return
      else
        raise StandardError.new("Error! Invalid input. Please choose either (y)es or (n)o")
      end
  end

  def open_campus_view(school)
    %x'open "#{school.campusview}"'
  end

  def help
    puts "Type 'exit' to exit"
    puts "Type 'help' to view this menu again"
    puts "Type 'c' or 'cuny' to search through cuny schools"
    puts "Type 's' or 'suny' to search through suny schools"
  end

end
