module RegenData
  ZERG_REGEN_COOLDOWN   = 2688
  SHIELD_REGEN_COOLDOWN = 1536

  extend ActiveSupport::Concern

  def regen
    @regen ||= if zerg?
                 ZERG_REGEN_COOLDOWN.multiples2
               elsif protoss?
                 SHIELD_REGEN_COOLDOWN.multiples2
               end
  end
end
