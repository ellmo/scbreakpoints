loaded_data = DataLoaderService.new.call.success

loaded_data["units"].each do |attrs|
  unit = Unit.find_or_initialize_by name: attrs["name"]

  unit.update! attrs
end
