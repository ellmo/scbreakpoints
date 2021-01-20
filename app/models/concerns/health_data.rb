module HealthData
  ZERG_REGEN_COOLDOWN   = 2688
  SHIELD_REGEN_COOLDOWN = 1536

  extend ActiveSupport::Concern

  def dead?
    current_hp <= 0
  end

  def shields?
    current_shield >=  0
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
    if shields?
      if current_shield >= attack.damage
        @current_shield -= attack.damage
      else
        remaining_damage = attack.damage - current_shield

        @current_shield = 0
        @current_hp -= remaining_damage * coefficient
      end
    else
      @current_hp -= attack.damage * coefficient
    end
  end

  def report_health
    if protoss?
      format(
        "%<name>-20s %<shield_cur>3d/%<shield_max>-3d | %<hp_cur>3d/%<hp_max>-3d",
        {
          name: name, shield_cur: current_shield, shield_max: shields,
          hp_cur: current_hp, hp_max: hitpoints
        }
      )
    else
      format(
        "%<name>-28s | %<hp_cur>3d/%<hp_max>-3d",
        { name: name, hp_cur: current_hp, hp_max: hitpoints }
      )
    end
  end

private

  def health_missing?
    current_hp < hitpoints
  end

  def shield_missing?
    current_shield < shields
  end
end
