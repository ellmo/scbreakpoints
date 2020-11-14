module HomeHelper
  def race_selector(name, mine: nil, theirs: nil)
    content_tag :li, class: ["tabs-title", active_element?(name, mine || theirs)] do
      link_to "", "##{mine ? 'my' : 'their'}-#{name}",
              class:           [name],
              "aria-selected": race_selected?(name, mine || theirs)
    end
  end

  def race_selected(arg)
    return arg.name if arg.is_a?(Race)
    return arg.race if arg.is_a?(Unit)

    nil
  end

  def mine?

  end

  def race_selected?(race, arg)
    race_selected(arg) == race
  end

  def active_element?(race, arg)
    race_selected?(race, arg) ? "is-active" : ""
  end
end
