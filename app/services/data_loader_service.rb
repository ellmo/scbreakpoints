# frozen_string_literal: true

class DataLoaderService < BaseService
  SC1_PATH = File.join(Rails.root, "data", "starcraft")

  pipe :load_entries do
    entries = Dir.each_child(SC1_PATH).each_with_object({}) do |filename, hsh|
      base_filename = filename.scan(/^\w+/).first
      file = File.read(File.join(SC1_PATH, filename))
      hsh[base_filename] = YAML.safe_load(file)
    end

    rslt { entries }
  end
end
