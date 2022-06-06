class Unit < ApplicationRecord
  SIZES = %w[small medium large].freeze
  # TYPES = %w[explosive plasma].freeze

#=======
# ASSOC
#=====
  # belongs_to :race
  has_many :slugs, dependent: :destroy

  attr_accessor :air, :slugnames

  # accepts_nested_attributes_for :slugs, allow_destroy: true

#======
#= DOC
#====
  # include Mongoid::Document

  # field :race,      type: String
  # field :name,      type: String
  # field :label,     type: String
  # field :size,      type: String,  default: "small"
  # field :flying,    type: Boolean, default: false
  # field :slugs,     type: Array

  # field :hitpoints, type: Integer
  # field :armor,     type: Integer, default: 0
  # field :shields,   type: Integer, default: 0

  # field :attack,    type: Hash

  attr_reader :current_hp, :current_shields

#============
#= CALLBACKS
#==========
  after_save :create_slugs
  # before_save :default_label, -> { name_changed? }
  after_initialize :load_health

#==========
#= METHODS
#========
  include AttackData
  include HealthData

  def self.find(slug)
    Unit.joins(:slugs).where({ slugs: { label: slug.downcase } }).first
    # Unit.find_by name: name
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

  def create_slugs
    Slug.find_or_create_by(unit_id: id, label: name)

    return unless slugnames

    slugnames.each do |label|
      Slug.find_or_create_by(unit_id: id, label: label)
    end
  end

  def default_label
    self.label ||= name.split("_").map(&:capitalize).join(" ")
  end
end
