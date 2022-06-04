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
    combatants = params[:combatants].split(":")

    @attacker = Unit.find(combatants.first)
    @target   = Unit.find(combatants.second)

    redirect_to "/marine:marine" unless @attacker && @target
  end
end
