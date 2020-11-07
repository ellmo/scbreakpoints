class Unit
  SIZES = %w[small medium large].freeze
  TYPES = %w[explosive plasma].freeze

  include Mongoid::Document
  field :race,      type: String
  field :name,      type: String
  field :size,      type: String
  field :slugs,     type: Array

  field :hitpoints, type: Integer
  field :armor,     type: Integer
  field :shields,   type: Integer

  field :attack,    type: Hash

  def size_i
    SIZES.index size
  end

  def type_i
    TYPES.index attack["ground"]["type"]
  end
end
