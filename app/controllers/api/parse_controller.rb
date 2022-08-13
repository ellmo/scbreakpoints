class ParseController < ApplicationController
  def index
    binding.pry
    render "ok"
  end

private

  def params
    @params ||= super.permit(:combatants)
  end
end
