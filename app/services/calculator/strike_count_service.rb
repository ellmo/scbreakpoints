# frozen_string_literal: true

# require "matrix"

class Calculator::StrikeCountService < BaseService
  COEFF_MATRIX = [[0.5, 0.75, 1.0], [0.25, 0.5, 1.0]].freeze
  SIZES        = %w[small medium large].freeze
  TYPES        = %w[explosive plasma].freeze
  # COEFF_MATRIX = Matrix[[0.25, 0.5, 1.0], [0.5, 0.75, 1.0]].freeze

  attribute :damage,    Types::Strict::Integer
  attribute :attacks,   Types::Strict::Integer
  attribute :armor,     Types::Strict::Integer
  attribute :hitpoints, Types::Strict::Integer
  attribute :shields,   Types::Strict::Integer.default(0)
  attribute :size,      Types::Strict::String.default("small")
  attribute :type,      Types::Strict::String.default("normal")

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
    return 1.0 if type == "normal"

    COEFF_MATRIX[type_i][size_i]
  end

  def body_damage(actual_damage = damage)
    [(attacks * (actual_damage * coefficient - armor)).round, 1].max
  end

  def size_i
    SIZES.index size
  end

  def type_i
    TYPES.index type
  end
end
