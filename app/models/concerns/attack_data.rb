module AttackData
  COEFF_MATRIX = [[0.5, 0.75, 1.0], [0.25, 0.5, 1.0]].freeze
  SIZES        = %w[small medium large].freeze
  DMG_TYPES    = %w[explosive plasma].freeze

  extend ActiveSupport::Concern

  def attack
    @attack ||= Attack.new(attributes["attack"]["ground"])
  end

  def attack_air
    @attack_air ||= case attributes["attack"]["air"]
                    when nil
                      nil
                    when "same"
                      attack
                    else
                      Attack.new(attributes["attack"]["air"])
                    end
  end
  alias air_attack attack_air

  def attack_vs(target)
    raise ArgumentError unless target.is_a? Unit

    target.flying ? attack_air : attack
  end

  def coefficient_vs(target)
    return nil if attack_vs(target).nil?
    return 1.0 if attack_vs(target).normal?

    COEFF_MATRIX[DMG_TYPES.index(attack_vs(target).type)][SIZES.index(target.size)]
  end
end
