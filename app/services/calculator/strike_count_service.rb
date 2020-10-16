# frozen_string_literal: true

class Calculator::StrikeCountService < BaseService
  attribute :damage,    Types::Strict::Integer
  attribute :attacks,   Types::Strict::Integer
  attribute :armor,     Types::Strict::Integer
  attribute :hitpoints, Types::Strict::Integer

  pipe :calculate_strikes do
    (hitpoints.to_f / (attacks * (damage - armor))).ceil
  end
end
