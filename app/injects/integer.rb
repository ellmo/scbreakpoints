class Integer
  def multiples(max: 10_000, from: 0)
    factor = from
    values = []

    loop do
      current = self * factor

      break if current > max

      values << current
      factor += 1
    end

    values
  end

  def multiples2(max: 10_000, from: 0)
    factor = from
    values = []

    until factor * self > max
      values << factor * self
      factor += 1
    end

    values
  end

  def color(value)
    to_s.color(value)
  end
end
