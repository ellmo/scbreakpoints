class HomeController < ApplicationController
  before_action :fetch_records_parse_params, :fetch_units

  attr_reader :attacker_string, :target_string

  def index
    render locals: { mine: @attacker, theirs: @target }
  end

  def params
    @params ||= super.permit(:combatants)
  end

private

  def fetch_records_parse_params
    @all_terran_units  ||= Unit.terran
    @all_protoss_units ||= Unit.protoss
    @all_zerg_units    ||= Unit.zerg

    combatants = params[:combatants].try(:split, ":")

    @attacker_string = combatants.try(:first)
    @target_string   = combatants.try(:last)
  end

  def fetch_units
    @attacker = attacker_string.race || Unit.find(attacker_string)
    @target   = target_string.race   || Unit.find(target_string)

    redirect_to "/terran:zerg" unless @attacker && @target
  end
end
