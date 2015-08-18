class School
  attr_reader :name
  attr_accessor :address, :campusview, :website

  def initialize(name)
    @name = name
  end

end
