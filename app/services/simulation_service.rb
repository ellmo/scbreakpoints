class SimulationService < BaseService
  attribute :red,     Types.Instance(Unit)
  attribute :blue,    Types.Instance(Unit)
  attribute :report,  Types::Strict::Bool.default(false)
  attribute :strikes, Types::Strict::Hash.default({ red: 0, blue: 0 }, shared: true)

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
    last_result.keys.sort.each do |timestamp|
      break if red.dead? || blue.dead?

      last_result[timestamp].each do |event|
        report ? handle_with_report(timestamp, event) : handle(event)
      end
    end

    message do
      if red.dead?
        "#{blue.label} wins, with #{strikes[:blue]} strikes against #{strikes[:red]}."
      else
        "#{red.label} wins, with #{strikes[:red]} strikes against #{strikes[:blue]}."
      end
    end
  end

private

  def handle(event)
    case event
    when "red_strike"
      red.attack.strikes.times { red.strike! }
      strikes[:red] += 1
    when "blue_strike"
      blue.attack.strikes.times { blue.strike! }
      strikes[:blue] += 1
    when "red_heal"
      red.heal!
    when "blue_heal"
      blue.heal!
    end
  end

  def handle_with_report(timestamp, event)
    case event
    when "red_strike"
      red.attack.strikes.times { red.report_strike!(timestamp, :red) }
      strikes[:red] += 1
    when "blue_strike"
      blue.attack.strikes.times { blue.report_strike!(timestamp, :blue) }
      strikes[:blue] += 1
    when "red_heal"
      red.heal!
    when "blue_heal"
      blue.heal!
    end
  end
end
