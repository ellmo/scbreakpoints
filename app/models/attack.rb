class Attack
  def initialize(input_hash)
    @input_hash  = input_hash
    @damage      = input_hash[:damage]
    @bonus       = input_hash[:bonus]   || 1
    @type        = input_hash[:type]    || 0
    @strikes     = input_hash[:attacks] || 1
    @cooldown    = input_hash[:cooldown]|| 1000
  end

  attr_reader :damage, :bonus, :type, :strikes, :cooldown
  alias attacks strikes

  def inspect
    optional_attrs = %w[bonus type strikes].map do |attribute|
      next unless input_hash.key? attribute

      "#{attribute}:#{public_send attribute}"
    end.compact.join(" ")

    optional_attrs.prepend(" ") if optional_attrs.present?

    "#<#{self.class.name}:#{object_id} damage:#{damage}#{optional_attrs}>"
  end

private

  attr_reader :input_hash

end
