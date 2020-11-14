module HomeHelper
  def race_selected?(race, arg)
    (arg.is_a?(Race) && arg.name == race) ||
      (arg.is_a?(Unit) && arg.race == race)
  end

  def active_element?(race, arg)
    race_selected?(race, arg) ? "is-active" : ""
  end
end
