class Unit
  include Mongoid::Document
  field :race,      type: String
  field :name,      type: String
  field :size,      type: String
  field :slugs,     type: Array

  field :hitpoints, type: Integer
  field :armor,     type: Integer
  field :shields,   type: Integer

  field :attack,    type: Hash
end
