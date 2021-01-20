class SimulationService < BaseService
  attribute :red,  Types.Instance(Unit)
  attribute :blue, Types.Instance(Unit)

  pipe :target_each_other do
    red.target!(blue)
    blue.target!(red)
  end

  pipe :generate_cooldown_tables do
    {
      red:  {
        strikes: red.strikes,
        heals:   red.regen || []
      },
      blue: {
        strikes: blue.strikes,
        heals:   blue.regen || []
      }
    }
  end

  pipe :reverse_merge_cooldown_tables do
    last_result.each_with_object({}) do |(color, table), hsh|
      table[:strikes].each { |timestamp| hsh[timestamp] = "#{color}_strike" }
      table[:heals].each   { |timestamp| hsh[timestamp] = "#{color}_heal" }
    end
  end

  pipe :traverse_timestamps do
    last_result.keys.sort.each do |key|
      break if red.dead? || blue.dead?

      case last_result[key]
      when "red_strike"
        red.attack.strikes.times { red.strike! }
        puts blue.report_health(:blue)
      when "blue_strike"
        blue.attack.strikes.times { blue.strike! }
        puts red.report_health(:red)
      when "red_heal"
        red.heal!
        puts red.report_health(:red)
      when "blue_heal"
        blue.heal!
        puts blue.report_health(:blue)
      end
    end
  end
end
