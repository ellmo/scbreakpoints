class Array
  def each_multiple(maximum, return_result = false)
    raise ArgumentError, "All elements need to be Numeric." \
      if reject { |x| x.is_a? Numeric }.present?

    base = 1_000_000
    results = []

    each do |factor|
      current_highest = 0
      index = 0
      while current_highest < maximum * base
        multiple = (factor * base * index).round 3
        results << multiple.to_f

        index += 1
        current_highest = multiple
      end
    end

    results = results.uniq.sort

    if block_given?
      results.each do |element|
        yield (element / base), self.select { |x| (element % (x * base)).zero? }
      end
    end

    results.map { |x| x / base } if return_result
  end
end
