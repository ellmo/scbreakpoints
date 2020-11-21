class HomeController < ApplicationController
  before_action :tvt_failsafe

  def index
    render locals: { mine: mine, theirs: theirs }
  end

  def mine
    @mine ||= record_for(params[:mine])
  end

  def theirs
    @theirs ||= record_for(params[:theirs])
  end

  def params
    @params ||= super.permit(:mine, :theirs)
  end

private

  def record_for(slug)
    Unit.find(slug) || Race.find(slug)
  end

  def tvt_failsafe
    return if mine && theirs

    redirect_to "/terran/terran"
  end
end
