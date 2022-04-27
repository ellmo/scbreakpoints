module HomeHelper
  def race_selector(race, mine: nil, theirs: nil)
    tag.li(class: selector_class(race, mine, theirs)) do
      link_to "", selector_href(race, mine).prepend("#"),
              aria:  selector_aria(race, mine, theirs),
              class: [race]
    end
  end

  def race_tab(race, mine: nil, theirs: nil)
    tag.div(id:    selector_href(race, mine),
            class: tab_class(race, mine, theirs)) do
      yield if block_given?
    end
  end

  def race_selected(arg)
    return arg.name if arg.is_a?(Race)
    return arg.race if arg.is_a?(Unit)

    nil
  end

  def race_selected?(race, arg)
    race_selected(arg) == race
  end

  def active_element?(race, arg)
    race_selected?(race, arg) ? "is-active" : ""
  end

  def selector_class(race, mine, theirs)
    ["tabs-title", active_element?(race, mine || theirs)]
  end

  def selector_href(race, mine)
    (mine ? "my-" : "their-") << race
  end

  def selector_aria(race, mine, theirs)
    { selected: race_selected?(race, mine || theirs) }
  end

  def tab_class(race, mine, theirs)
    ["tabs-panel", active_element?(race, mine || theirs)]
  end
end
