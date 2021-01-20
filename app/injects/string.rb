class String
  COLOR_CODES = {
    black:      30,
    red:        31,
    green:      32,
    brown:      33,
    blue:       34,
    magenta:    35,
    cyan:       36,
    gray:       37,
    #------------#
    bg_black:   40,
    bg_red:     41,
    bg_green:   42,
    bg_brown:   43,
    bg_blue:    44,
    bg_magenta: 45,
    bg_cyan:    46,
    bg_gray:    47
  }.freeze

  def color(value)
    color_code = COLOR_CODES[value.to_sym]

    "\e[#{color_code}m#{self}\e[0m"
  end
end
