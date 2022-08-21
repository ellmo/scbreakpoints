module Api
  class ParseController < ApplicationController
    attr_reader :attacker, :target

    def index
      parse_combatants

      render json: { attacker: attacker.name, target: target.name }
    end

  private

    def params
      @params ||= super.permit(:combatants)
    end

    def parse_combatants
      combatants = params[:combatants].try(:split, ":")

      @attacker = Unit.find(combatants.try(:first)) || Unit.find("marine")
      @target   = Unit.find(combatants.try(:last)) || Unit.find("ling")
    end
  end
end
