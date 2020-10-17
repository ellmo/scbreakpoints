# frozen_string_literal: true

class Calculator::UnitService < BaseService
  attribute :unit,   Types::Strict::String
  attribute :target, Types::Strict::String
  attribute :data,   Types::Strict::Hash.optional.default({}.freeze)

  # pipe :fetch_data do
  #   binding.pry
  #   bump(:data) { Rails.cache.fetch("date") }
  # end

  pipe :prepare_attack_values do
    {
      damage:    unit_fetch("damage"),
      attacks:   unit_fetch("attacks"),
      bonus:     unit_fetch("bonus"),
      type:      unit_fetch("type"),
      hitpoints: target_fetch("hitpoints"),
      armor:     target_fetch("armor"),
      size:      target_fetch("size")
    }
  end

  pipe :calculate_breakpoints do
    Calculator::Breakpoints
      .new(last_result)
      .call
  end

  # pipe :calculate_strikes do
  #   Calculator::StrikeCountService
  #     .new(last_result)
  #     .call
  # end

  def unit_fetch(key)
    data["units"][unit][key]
  end

  def target_fetch(key)
    data["units"][target][key]
  end
end
