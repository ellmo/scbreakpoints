module HealthData
  ZERG_REGEN_COOLDOWN   = 2688
  ZERG_REGEN_OFFSET     = 50
  SHIELD_REGEN_COOLDOWN = 1536
  SHIELD_REGEN_OFFSET   = 1536

  extend ActiveSupport::Concern

  def dead?
    current_hp <= 0
  end

  def shields?
    current_shields.positive?
  end

  def regen
    @regen ||= if zerg?
                 ZERG_REGEN_COOLDOWN.multiples(offset: ZERG_REGEN_OFFSET)
               elsif protoss?
                 SHIELD_REGEN_COOLDOWN.multiples(offset: SHIELD_REGEN_OFFSET)
               end
  end

  def harm!(attack, coefficient = 1) # rubocop:disable Metrics/MethodLength
    damage = nil
    if shields?
      if current_shields >= attack.damage
        damage = attack.damage
        @current_shields -= damage
      else
        remaining_damage = attack.damage - current_shields
        penetrate_damage = (remaining_damage * coefficient).round - armor
        damage = @current_shields + penetrate_damage

        @current_shields = 0
        @current_hp -= penetrate_damage
      end
    else
      damage = (attack.damage * coefficient).round - armor
      @current_hp -= damage
    end
    damage
  end

  def heal!(value = 1)
    if zerg? && health_missing?
      @current_hp += value
    elsif protoss? && shield_missing?
      @current_shields += value
    end
  end

  def report_heal!(timestamp, side, heal_value = 1) # rubocop:disable Metrics/PerceivedComplexity
    if zerg? && health_missing?
      @current_hp += heal_value
      heal_value = "+#{heal_value}".color(:green)
    elsif protoss? && shield_missing?
      @current_shields += heal_value
      heal_value = "+#{heal_value}".color(:cyan)
    end

    if side == :red
      StdoutReporter.report_blue(target, timestamp, heal_value)
    else
      StdoutReporter.report_red(target, timestamp, heal_value)
    end
  end

private

  def health_missing?
    current_hp < hitpoints
  end

  def shield_missing?
    current_shields < shields
  end
end
