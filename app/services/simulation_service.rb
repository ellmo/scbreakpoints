class SimulationService < BaseService
  attribute :blue,    Types.Instance(Unit)
  attribute :red,     Types.Instance(Unit)
  attribute :report,  Types::Strict::Bool.default(false)
  attribute :strikes, Types::Strict::Hash.default({ blue: 0, red: 0 }, shared: true)

  pipe :target_each_other do
    blue.target!(red)
    red.target!(blue)
  end

  pipe :reset_strikes do
    bump(:strikes) { { blue: 0, red: 0 } }
  end

  pipe :generate_cooldown_tables do
    {
      blue: {
        strikes: blue.strikes,
        heals:   blue.regen || []
      },
      red:  {
        strikes: red.strikes,
        heals:   red.regen || []
      }
    }
  end

  pipe :reverse_merge_cooldown_tables do
    last_result.each_with_object({}) do |(color, table), hsh|
      table[:strikes].each do |timestamp|
        hsh[timestamp] ||= []
        hsh[timestamp] << "#{color}_strike"
      end
      table[:heals].each do |timestamp|
        hsh[timestamp] ||= []
        hsh[timestamp] << "#{color}_heal"
      end
    end
  end

  pipe :traverse_timestamps do
    StdoutReporter.print_header if report

    last_result.keys.sort.each do |timestamp|
      break if blue.dead? || red.dead?

      last_result[timestamp].each do |event|
        report ? handle_with_report(timestamp, event) : handle(event)
      end
    end

    message do
      if blue.dead?
        { winner: red, hits: strikes[:red], against: strikes[:blue] }
      else
        { winner: blue, hits: strikes[:blue], against: strikes[:red] }
      end
    end
  end

private

  def handle(event)
    case event
    when "blue_strike"
      blue.attack.strikes.times { blue.strike! }
      strikes[:blue] += 1
    when "red_strike"
      red.attack.strikes.times { red.strike! }
      strikes[:red] += 1
    when "blue_heal"
      blue.heal!
    when "red_heal"
      red.heal!
    end
  end

  def handle_with_report(timestamp, event)
    case event
    when "blue_strike"
      blue.attack.strikes.times { blue.report_strike!(timestamp, :blue) }
      strikes[:blue] += 1
    when "red_strike"
      red.attack.strikes.times { red.report_strike!(timestamp, :red) }
      strikes[:red] += 1
    when "blue_heal"
      blue.report_heal!(timestamp, :blue)
    when "red_heal"
      red.report_heal!(timestamp, :red)
    end
  end
end
