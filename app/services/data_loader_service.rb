# frozen_string_literal: true

class DataLoaderService < BaseService
  SC1_PATH = Rails.root.join("data/broodwar")

  pipe :load_entries do
    start_hash = { "units" => [] }

    entries = Dir.each_child(SC1_PATH).each_with_object(start_hash) do |filename, hsh|
      base_filename = filename.scan(/^\w+/).first
      file = File.read(File.join(SC1_PATH, filename))

      data = JSON.parse(file)

      data["units"].each do |attributes|
        attributes["race"] = base_filename
      end

      hsh["units"].concat data["units"]
    end

    rslt { entries }
  end
end
