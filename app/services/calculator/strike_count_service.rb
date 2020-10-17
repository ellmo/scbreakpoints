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
  attribute :size,      Types::Strict::String.default("small")
  attribute :type,      Types::Strict::String.default("normal")

  pipe :calculate_coefficient do
    bump(:damage) { damage * coefficient }
  end

  pipe :calculate_strikes do
    (hitpoints.to_f / (attacks * (damage - armor))).ceil
  end

  def coefficient
    return 1.0 if type == "normal"

    COEFF_MATRIX[type_i][size_i]
  end

  def size_i
    SIZES.index size
  end

  def type_i
    TYPES.index type
  end
end
