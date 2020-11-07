# frozen_string_literal: true

class DataLoaderService < BaseService
  SC1_PATH = File.join(Rails.root, "data", "starcraft")

  pipe :load_entries do
    start_hash = { "units" => {} }

    entries = Dir.each_child(SC1_PATH).each_with_object(start_hash) do |filename, hsh|
      base_filename = filename.scan(/^\w+/).first
      file = File.read(File.join(SC1_PATH, filename))

      data = YAML.safe_load(file)

      data["units"].each_pair do |_unit, attributes|
        attributes["race"] = base_filename
      end

      hsh["units"].merge! data["units"]
    end

    rslt { entries }
  end
end
