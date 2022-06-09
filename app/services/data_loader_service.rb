# frozen_string_literal: true

class DataLoaderService < BaseService
  SC1_PATH = Rails.root.join("data/starcraft")

  pipe :load_entries do
    start_hash = { units: [] }

    entries = Dir.each_child(SC1_PATH).each_with_object(start_hash) do |filename, hsh|
      race = filename.scan(/^\w+/).first
      file = File.read(File.join(SC1_PATH, filename))
      data = YAML.safe_load(file).try(:deep_symbolize_keys)

      next unless data

      data[:units].each_pair do |unit_name, attributes|
        hsh[:units] << transform_unit_attributes(attributes.merge(name: unit_name, race: race))
      end
    end

    rslt { entries }
  end

  # pipe :seed_entries do
    # unit = Unit.find_or_initialize_by name: unit_name
    # unit.update! attrs
  # end

  #   Transform YAML loaded attributes to "model-appropriate"
  def transform_unit_attributes(attributes)
    unit_data = {
      name:  attributes[:name],
      label: attributes.delete(:label) || attributes[:name].to_s.titleize,
      race:  attributes[:race].capitalize,
      size:  size_to_i(attributes.delete(:size))
    }.merge(attributes.slice(:hitpoints, :shields, :armor, :flying, :slugnames))

    # return early if no attacks are present at all
    return unit_data unless attributes[:attack]

    unit_data.merge! attack_data(attributes)
    unit_data.merge! attack_data(attributes, :air)
    unit_data
  end

  #   Prepares a "model-appropriate" attack hash from YAML loaded attack data
  def attack_data(attributes, target = :ground)
    prefix = target == :ground ? "g" : "a"
    attack = attributes.dig(:attack, target)

    # return empty attack hash if there's no attack present
    return {} unless attack

    # map attack string to integer value
    attack[:type] = attack_type_to_i(attack[:type]) if attack.is_a? Hash

    # use ground attack data (but with air prefix) if air attack is "same" as ground
    if target == :air && attack == "same"
      attributes.dig(:attack, :ground).try(:transform_keys) { |k| :"a_#{k}" }
    else
      attack.try(:transform_keys) { |k| :"#{prefix}_#{k}" }
    end
  end

  def size_to_i(value)
    %w[small medium large].index(value) || 0
  end

  def attack_type_to_i(value)
    %w[normal explosive plasma].index(value) || 0
  end
end
