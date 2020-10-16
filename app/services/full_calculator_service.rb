# frozen_string_literal: true

class FullCalculatorService < BaseService
  attribute :race, Types::Strict::Symbol
  attribute :opponent, Types::Strict::Symbol

  pipe :load_data do
    DataLoaderService.new.call
  end

  pipe :assign_races do
    data = last_result.with_indifferent_access

    bump(:race) { data[race] }
    bump(:opponent) { data[opponent] }
  end

  pipe :step_3 do

  end
end
