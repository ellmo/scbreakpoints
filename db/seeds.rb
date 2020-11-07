loaded_data = DataLoaderService.new.call.success

loaded_data["units"].each do |unit_name, unit_attrs|
  unit = Unit.find_or_initialize_by name: unit_name

  unit.update! unit_attrs
end
