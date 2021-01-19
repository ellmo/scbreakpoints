class SimulationService < BaseService
  attribute :red,  Types.Instance(Unit)
  attribute :blue, Types.Instance(Unit)

  pipe :generate_cooldown_tables do
    {
      red:  {
        strikes: red.strikes_vs(blue),
        heals:   red.regen
      },
      blue: {
        strikes: blue.strikes_vs(red),
        heals:   blue.regen
      }
    }
  end

  pipe :asd do
    binding.pry

    true
  end
end
