module Api
  class ParseController < ApplicationController
    def index
      render json: { attacker: 24, target: "protoss" }
    end

  private

    # def params
    #   @params ||= super.permit(:combatants)
    # end

    # def parse_combatants
    #   combatants = params[:combatants].try(:split, ":")

    #   @attacker_string = combatants.try(:first)
    #   @target_string   = combatants.try(:last)
    # end

    # def fetch_units
    #   @attacker = attacker_string.race || Unit.find(attacker_string)
    #   @target   = target_string.race   || Unit.find(target_string)

    #   redirect_to "/terran:zerg" unless @attacker && @target
    # end
  end
end
