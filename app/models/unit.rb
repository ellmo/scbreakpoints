class Unit < ApplicationRecord
  SIZES = %w[small medium large].freeze
  # TYPES = %w[explosive plasma].freeze

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
  before_save :copy_attack_data!
  after_save :create_slugs!
  after_initialize :load_health

#==========
#= METHODS
#========
  include AttackData
  include HealthData

  def self.find(slug)
    Unit.joins(:slugs).where({ slugs: { label: slug.downcase } }).first
  end

  def load_health
    @current_hp      = hitpoints
    @current_shields = shields
  end

  def size
    SIZES.index read_attribute(:size)
  end

  # def type_i
  #   # TYPES.index attack["ground"]["type"]
  # end

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
  #   "#<Unit:#{name} race:#{race} >"
  # end

private

  def create_slugs!
    Slug.find_or_create_by(unit_id: id, label: name)

    return unless slugnames

    slugnames.each do |label|
      Slug.find_or_create_by(unit_id: id, label: label)
    end
  end

  def copy_attack_data!
    return unless air == "same"
    return if [g_damage, a_damage].all?(:nil) || [g_damage, a_damage].all?(&:present?)

    self.a_damage   = g_damage
    self.a_cooldown = g_cooldown
    self.a_attacks  = g_attacks
    self.a_bonus    = g_bonus
    self.a_type     = g_type
  end
end
