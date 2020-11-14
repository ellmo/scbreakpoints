# frozen_string_literal: true

require "forwardable"

class Calculator::StrikeCountService < BaseService
  attribute :unit,          Types::Strict::String
  attribute :target,        Types::Strict::String
  attribute :bonus_attack,  Types::Strict::Integer.default(0)
  attribute :bonus_armor,   Types::Strict::Integer.default(0)
  attribute :bonus_shield,  Types::Strict::Integer.default(0)

  extend Forwardable
  def_delegators :attack, :attacks
  def_delegators :target, :hitpoints, :shields

  pipe :fetch_data do
    bump(:unit)   { Unit.find unit }
    bump(:target) { Unit.find target }
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
    @coefficient ||= unit.coefficient_vs(target)
  end

  def attack
    @attack ||= unit.attack_vs(target)
  end

  def body_damage(actual_damage = damage)
    [(attacks * (actual_damage * coefficient - armor)).round, 1].max
  end

  def damage
    attack.damage + (bonus_attack * attack.bonus)
  end

  def armor
    target.armor + bonus_armor
  end
end
