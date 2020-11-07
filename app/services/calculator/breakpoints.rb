# frozen_string_literal: true

require "matrix"

class Calculator::Breakpoints < BaseService
  MAX_UPGRADES = 3

  attribute :unit,   Types::Strict::String
  attribute :target, Types::Strict::String

  pipe :build_strike_matrix do
    Matrix.build(MAX_UPGRADES + 1) do |dam_upgrade, arm_upgrade|
      # label = "D#{dam_upgrade}:A#{arm_upgrade}"
      strikes = Calculator::StrikeCountService
                .new(
                  unit:         unit,
                  target:       target,
                  bonus_attack: dam_upgrade,
                  bonus_armor:  arm_upgrade
                )
                .call
                .success
      # "[#{label}] => #{strikes}"
      strikes
    end
  end

  def corrected_params(dam_upgrade, arm_upgrade)
    attributes.merge(damage: damage + dam_upgrade, armor: armor + arm_upgrade)
  end
end
