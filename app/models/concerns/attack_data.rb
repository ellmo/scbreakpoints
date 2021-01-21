module AttackData
  COEFF_MATRIX = [[0.5, 0.75, 1.0], [0.25, 0.5, 1.0]].freeze
  SIZES        = %w[small medium large].freeze
  DMG_TYPES    = %w[explosive plasma].freeze

  REPORT_TEMPLATE_RED =
    "[%6d]:[%20s][%13s/%13s][%13s/%13s] ---{%3s}--> [%20s][%13s/%13s][%13s/%13s]".freeze
  REPORT_TEMPLATE_BLU =
    "[%6d]:[%20s][%13s/%13s][%13s/%13s] <--{%3s}--- [%20s][%13s/%13s][%13s/%13s]".freeze

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
    damage_done = target.harm!(attack, coefficient)

    report = if side == :red
               format(REPORT_TEMPLATE_RED, timestamp, *red_report_values(damage_done))
             else
               format(REPORT_TEMPLATE_BLU, timestamp, *blue_report_values(damage_done))
             end
    puts report
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

  def red_report_values(damage_done)
    [
      label.color(:red),
      current_shields.color(:cyan),
      shields.color(:cyan),
      current_hp.color(:green),
      hitpoints.color(:green),
      damage_done.color(:brown),
      target.label.color(:blue),
      target.current_shields.color(:cyan),
      target.shields.color(:cyan),
      target.current_hp.color(:green),
      target.hitpoints.color(:green)
    ]
  end

  def blue_report_values(damage_done)
    [
      target.label.color(:red),
      target.current_shields.color(:cyan),
      target.shields.color(:cyan),
      target.current_hp.color(:green),
      target.hitpoints.color(:green),
      damage_done.color(:brown),
      label.color(:blue),
      current_shields.color(:cyan),
      shields.color(:cyan),
      current_hp.color(:green),
      hitpoints.color(:green)
    ]
  end
end
