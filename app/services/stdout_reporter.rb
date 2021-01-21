class StdoutReporter
  HEADER =
    "\e[30m\e[47mtimestamp\e[0m\e[0m" \
    "\e[30m\e[44m        BLUE UNIT \e[0m\e[0m" \
    "\e[30m\e[46m  SHIELDS  \e[0m\e[0m" \
    "\e[30m\e[42m HITPOINTS \e[0m\e[0m" \
    "\e[31m\e[43m   ACTION   \e[0m\e[0m" \
    "\e[30m\e[41m RED UNIT         \e[0m\e[0m" \
    "\e[30m\e[46m  SHIELDS  \e[0m\e[0m" \
    "\e[30m\e[42m HITPOINTS \e[0m\e[0m".freeze

  REPORT_RED =
    "[%6d]:[%25s][%13s/%13s][%13s/%13s] %19s [%-25s][%13s/%13s][%13s/%13s]".freeze
  REPORT_BLUE =
    "[%6d]:[%25s][%13s/%13s][%13s/%13s] %-19s [%-25s][%13s/%13s][%13s/%13s]".freeze

  def self.print_header
    puts HEADER
  end

  def self.report_red(unit, timestamp, health_change)
    puts format(REPORT_RED, timestamp, *red_report_values(unit, health_change))
  end

  def self.report_blue(unit, timestamp, health_change)
    puts format(REPORT_BLUE, timestamp, *blue_report_values(unit, health_change))
  end

  class << self
    private

    def red_report_values(unit, health_change)
      [
        unit.label.color(:red),
        unit.current_shields.color(:cyan),
        unit.shields.color(:cyan),
        unit.current_hp.color(:green),
        unit.hitpoints.color(:green),
        health_change,
        unit.target.label.color(:blue),
        unit.target.current_shields.color(:cyan),
        unit.target.shields.color(:cyan),
        unit.target.current_hp.color(:green),
        unit.target.hitpoints.color(:green)
      ]
    end

    def blue_report_values(unit, health_change)
      [
        unit.target.label.color(:red),
        unit.target.current_shields.color(:cyan),
        unit.target.shields.color(:cyan),
        unit.target.current_hp.color(:green),
        unit.target.hitpoints.color(:green),
        health_change,
        unit.label.color(:blue),
        unit.current_shields.color(:cyan),
        unit.shields.color(:cyan),
        unit.current_hp.color(:green),
        unit.hitpoints.color(:green)
      ]
    end
  end
end
