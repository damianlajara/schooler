class AllAboutSchools

  def call
    puts "Welcome, what type of schools would you like to search through? (C)UNY or (S)UNY"
    run
  end

  def get_user_input
    gets.chomp.strip
  end

  def run
    print "School type: "
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

  def display(array)
    array.each.with_index {|element,index| puts "#{index.next}. #{element}"}
  end

  def process_cuny_schools
    url = "http://www2.cuny.edu/about/colleges-schools/"
    schools = SchoolScraper.new(url).filter_schools
    puts "Found your cuny schools!"
    display schools
  end

  def process_suny_schools
    url = "http://www.suny.edu/attend/visit-us/complete-campus-list/"
    schools = SchoolScraper.new(url).filter_schools
    puts "Found your suny schools!"
    display schools
  end

  def help
    puts "Type 'exit' to exit"
    puts "Type 'help' to view this menu again"
    puts "Type 'c' or 'cuny' to search through cuny schools"
    puts "Type 's' or 'suny' to search through suny schools"
  end

end
