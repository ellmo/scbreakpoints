# frozen_string_literal: true

require "matrix"

class Calculator::Breakpoints < BaseService
  MAX_UPGRADES = 3

  attribute :armor,     Types::Strict::Integer
  attribute :attacks,   Types::Strict::Integer
  attribute :bonus,     Types::Strict::Integer
  attribute :damage,    Types::Strict::Integer
  attribute :hitpoints, Types::Strict::Integer
  attribute :size,      Types::Strict::String.default("small")
  attribute :type,      Types::Strict::String.default("normal")

  pipe :build_strike_matrix do
    matrix = Matrix.build(MAX_UPGRADES + 1) do |dam_upgrade, arm_upgrade|
      # label = "D#{dam_upgrade}:A#{arm_upgrade}"
      strikes = Calculator::StrikeCountService
                .new(corrected_params(dam_upgrade * bonus, arm_upgrade))
                .call
                .success
      # "[#{label}] => #{strikes}"
      strikes
    end
    matrix
  end

  def corrected_params(dam_upgrade, arm_upgrade)
    attributes.merge(damage: damage + dam_upgrade, armor: armor + arm_upgrade)
  end
end
