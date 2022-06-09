class Unit < ApplicationRecord
  SIZES = %w[small medium large].freeze

#=======
# ASSOC
#=====
  # belongs_to :race
  has_many :slugs, dependent: :destroy

  attr_accessor :air, :slugnames
  attr_reader :current_hp, :current_shields

#============
#= CALLBACKS
#==========
  # before_save :copy_attack_data!
  after_save :create_slugs!
  after_initialize :load_health

#==========
#= METHODS
#========
  include AttackData
  include HealthData

  def self.find(slug)
    return nil unless slug

    Unit.joins(:slugs).where({ slugs: { label: slug.downcase } }).first
  end

  def load_health
    @current_hp      = hitpoints
    @current_shields = shields
  end

  def size_s
    SIZES[size]
  end

  def protoss?
    race == "protoss"
  end

  def terran?
    race == "terran"
  end

  def zerg?
    race == "zerg"
  end

  # def to_s
  #   "<Unit:#{label} asd>"
  # end

  def inspect
    if target
      "<Unit:#{self[:label]} attack:#{attack.damage}>"
    else
      "<Unit:#{self[:label]}>"
    end
  end

private

  def create_slugs!
    Slug.find_or_create_by(unit_id: id, label: name)

    return unless slugnames

    slugnames.each do |label|
      Slug.find_or_create_by(unit_id: id, label: label)
    end
  end
end
