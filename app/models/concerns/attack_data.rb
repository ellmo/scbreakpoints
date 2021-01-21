module AttackData
  COEFF_MATRIX = [[0.5, 0.75, 1.0], [0.25, 0.5, 1.0]].freeze
  SIZES        = %w[small medium large].freeze
  DMG_TYPES    = %w[explosive plasma].freeze

  extend ActiveSupport::Concern

  included do
    attr_reader :target
  end

  def target!(target_unit)
    @target = target_unit
  end

  def attack
    raise ArgumentError unless target.is_a? Unit

    @attack ||= target.flying ? attack_air : ground_attack
  end

  def coefficient
    return nil if attack.nil?
    return 1.0 if attack.normal? || target.shields?

    @coefficient = COEFF_MATRIX[DMG_TYPES.index(attack.type)][SIZES.index(target.size)]
  end

  def strikes
    @strikes ||= attack.cooldown.multiples
  end

  def strike!
    target.harm!(attack, coefficient)
  end

  def report_strike!(timestamp, side)
    damage_done = "-#{target.harm!(attack, coefficient)}".color(:brown)

    if side == :red
      StdoutReporter.report_red(self, timestamp, damage_done)
    else
      StdoutReporter.report_blue(self, timestamp, damage_done)
    end
  end

private

  def ground_attack
    @ground_attack ||= Attack.new(attributes["attack"]["ground"])
  end

  def air_attack
    @air_attack ||= case attributes["attack"]["air"]
                    when nil
                      nil
                    when "same"
                      ground_attack
                    else
                      Attack.new(attributes["attack"]["air"])
                    end
  end
  alias attack_air air_attack
end
