class Unit
  SIZES = %w[small medium large].freeze
  TYPES = %w[explosive plasma].freeze

#======
#= DOC
#====
  include Mongoid::Document
  field :race,      type: String
  field :name,      type: String
  field :size,      type: String,  default: "small"
  field :flying,    type: Boolean, default: false
  field :slugs,     type: Array

  field :hitpoints, type: Integer
  field :armor,     type: Integer, default: 0
  field :shields,   type: Integer, default: 0

  field :attack,    type: Hash

#============
#= CALLBACKS
#==========
  before_save :add_name_to_slugs, -> { slugs_changed? }

#==========
#= METHODS
#========
  include AttackData

  def self.find(slug)
    Unit.find_by slugs: slug
  end
  def size_i
    SIZES.index size
  end

  def type_i
    TYPES.index attack["ground"]["type"]
  end

private

  def add_name_to_slugs
    if slugs.present? && slugs.index(name).nil?
      slugs << name
    else
      self.slugs = [name]
    end
  end
end
