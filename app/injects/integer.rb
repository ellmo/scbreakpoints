class Integer
  def multiples(max: 100_000, from: 0, offset: 0)
    factor = from
    values = []

    until (value = factor * self + offset) > max
      values << value
      factor += 1
    end

    values
  end

  delegate :color, to: :to_s
end
