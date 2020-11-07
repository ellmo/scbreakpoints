# frozen_string_literal: true

# require "matrix"

class Calculator::StrikeCountService < BaseService
  COEFF_MATRIX = [[0.5, 0.75, 1.0], [0.25, 0.5, 1.0]].freeze
  SIZES        = %w[small medium large].freeze
  TYPES        = %w[explosive plasma].freeze
  # COEFF_MATRIX = Matrix[[0.25, 0.5, 1.0], [0.5, 0.75, 1.0]].freeze

  attribute :unit,          Types::Strict::String
  attribute :target,        Types::Strict::String
  attribute :bonus_attack,  Types::Strict::Integer.default(0)
  attribute :bonus_armor,   Types::Strict::Integer.default(0)
  attribute :bonus_shield,  Types::Strict::Integer.default(0)

  pipe :fetch_data do
    bump(:unit)   { Unit.find_by name: unit }
    bump(:target) { Unit.find_by name: target }
  end

  pipe :shield_strikes_and_carryover do
    if shields.positive?
      { strikes: (shields.to_f / damage).ceil, carryover: (damage - (shields % damage)) }
    else
      { strikes: 0, carryover: 0 }
    end
  end

  pipe :shield_penetration do
    bump(:hitpoints) { hitpoints - body_damage(last_result[:carryover]) } if shields.positive?
    last_result[:strikes]
  end

  pipe :calculate_strikes do
    last_result + (hitpoints.to_f / body_damage).ceil
  end

  def coefficient
    return 1.0 if unit.type_i.nil?

    COEFF_MATRIX[unit.type_i][target.size_i]
  end

  def body_damage(actual_damage = damage)
    [(attacks * (actual_damage * coefficient - armor)).round, 1].max
  end

  def damage
    (unit.attack["ground"]["damage"]) + (bonus_attack * unit.attack["ground"]["bonus"])
  end

  def attacks
    unit.attack["ground"]["attacks"]
  end

  def shields
    target.shields || 0
  end

  def armor
    target.armor + bonus_armor
  end

  def hitpoints
    target.hitpoints
  end
end
