module AttackData
  COEFF_MATRIX = [[1.0, 1.0, 1.0], [0.5, 0.75, 1.0], [0.25, 0.5, 1.0]].freeze
  # SIZES        = %w[small medium large].freeze
  # DMG_TYPES    = %w[normal explosive plasma].freeze

  extend ActiveSupport::Concern

  included do
    attr_reader :target
  end

  def target!(target_unit)
    @target = target_unit
  end

  def attack
    raise ArgumentError unless target.is_a? Unit

    @attack ||= target.flying ? air_attack : ground_attack
  end

  def coefficient
    return nil if attack.nil?

    @coefficient = COEFF_MATRIX[attack.type][target.size]
  end

  def strikes
    return [] unless attack

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
    @ground_attack ||= g_damage ? Attack.new(ground_attack_attributes) : nil
  end

  def air_attack
    @air_attack ||= a_damage ? Attack.new(air_attack_attributes) : nil
  end
  alias attack_air air_attack

  def ground_attack_attributes
    {
      damage:   g_damage,
      attacks:  g_attacks,
      cooldown: g_cooldown,
      bonus:    g_bonus,
      type:     g_type
    }
  end

  def air_attack_attributes
    {
      damage:   a_damage,
      attacks:  a_attacks,
      cooldown: a_cooldown,
      bonus:    a_bonus,
      type:     a_type
    }
  end
end
