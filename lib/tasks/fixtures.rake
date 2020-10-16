namespace :fixtures do
  task dump: :environment do
    DUMP_PATH = File.join(Rails.root, "spec", "fixtures", "data.dump")

    result = DataLoaderService.new.call
    return unless result.success?

    File.open(DUMP_PATH, "wb") { |f| f.write(Marshal.dump(result.success)) }
  end
end


