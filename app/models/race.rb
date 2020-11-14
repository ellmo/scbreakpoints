class Race
  NAMES = %w[terran zerg protoss].freeze

  def initialize(name)
    @name = name
  end

  attr_reader :name

#==========
#= METHODS
#========
  def units
    Unit.where(race: name)
  end

  def self.find(name)
    return unless name.in? NAMES

    self.new(name)
  end

end
