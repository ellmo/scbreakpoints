class Integer
  def multiples(max: 10_000, from: 0, offset: 0)
    factor = from
    values = []

    until (value = factor * self + offset) > max
      values << value
      factor += 1
    end

    values
  end

  def color(value)
    to_s.color(value)
  end
end
