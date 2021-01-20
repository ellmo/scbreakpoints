module HealthData
  ZERG_REGEN_COOLDOWN   = 2688
  SHIELD_REGEN_COOLDOWN = 1536

  REPORT_W_SHIELDS =
    "%<name>-30s %<shield_cur>3s/%<shield_max>-3s | %<hp_cur>3s/%<hp_max>-3s".freeze
  REPORT_HITPOINTS =
    "%<name>-38s | %<hp_cur>3s/%<hp_max>-3s".freeze
  REPORT_DEAD =
    "%<name>-38s | >>DEAD<<".freeze

  extend ActiveSupport::Concern

  def dead?
    current_hp <= 0
  end

  def shields?
    current_shield.positive?
  end

  def regen
    @regen ||= if zerg?
                 ZERG_REGEN_COOLDOWN.multiples2
               elsif protoss?
                 SHIELD_REGEN_COOLDOWN.multiples2
               end
  end

  def heal!(value = 1)
    if zerg? && health_missing?
      @current_hp += value
    elsif protoss? && shield_missing?
      @current_shield += value
    end
  end

  def harm!(attack, coefficient = 1)
    damage = nil
    if shields?
      if current_shield >= attack.damage
        damage = attack.damage
        @current_shield -= damage
      else
        remaining_damage = attack.damage - current_shield
        penetrate_damage = (remaining_damage * coefficient).round - armor
        damage = @current_shield + penetrate_damage

        @current_shield = 0
        @current_hp -= penetrate_damage
      end
    else
      damage = (attack.damage * coefficient).round - armor
      @current_hp -= damage
    end
    damage
  end

  def report_health(unit_color)
    if dead?
      report_dead(unit_color)
    elsif protoss?
      report_w_shields(unit_color)
    else
      report_hitpoints(unit_color)
    end
  end

private

  def health_missing?
    current_hp < hitpoints
  end

  def shield_missing?
    current_shield < shields
  end

  def report_dead(unit_color)
    format(REPORT_DEAD, name: "[#{name.color(unit_color)}]")
  end

  def report_w_shields(unit_color)
    format(
      REPORT_W_SHIELDS,
      {
        name: "[#{name.color(unit_color)}]", shield_cur: current_shield.color(:cyan),
        shield_max: shields.color(:cyan), hp_cur: current_hp.color(:red),
        hp_max: hitpoints.color(:red)
      }
    )
  end

  def report_hitpoints(unit_color)
    format(
      REPORT_HITPOINTS,
      { name: "[#{name.color(unit_color)}]", hp_cur: current_hp.color(:red),
        hp_max: hitpoints.color(:red) }
    )
  end
end
