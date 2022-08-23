class HomeController < ApplicationController
  before_action :fetch_records

  def index; end

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
