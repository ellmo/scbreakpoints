class HomeController < ApplicationController
  before_action :fetch_records

  def index
    render locals: { mine: @attacker, theirs: @target }
  end

  def params
    @params ||= super.permit(:combatants)
  end

private

  def fetch_records
    @all_terran_units  ||= Unit.terran
    @all_protoss_units ||= Unit.protoss
    @all_zerg_units    ||= Unit.zerg

    combatants = params[:combatants].try(:split, ":")

    @attacker = Unit.find(combatants.try(:first))
    @target   = Unit.find(combatants.try(:second))

    redirect_to "/marine:marine" unless @attacker && @target
  end
end
