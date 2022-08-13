class HomeController < ApplicationController
  before_action :fetch_records

  attr_reader :attacker_string, :target_string

  def index
    render locals: { mine: nil, theirs: nil }
    # render locals: { mine: @attacker, theirs: @target }
  end

  def params
    @params ||= super.permit(:combatants)
  end

private

  def fetch_records
    @all_terran_units  ||= Unit.terran
    @all_protoss_units ||= Unit.protoss
    @all_zerg_units    ||= Unit.zerg

    nil
  end
end
