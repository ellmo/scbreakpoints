class Unit
  SIZES = %w[small medium large].freeze
  TYPES = %w[explosive plasma].freeze

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

  include AttackData

  def size_i
    SIZES.index size
  end

  def type_i
    TYPES.index attack["ground"]["type"]
  end
end
