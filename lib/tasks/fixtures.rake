namespace :fixtures do
  task dump: :environment do
    dump_path = Rails.root.join("spec/fixtures/data.dump")

    result = DataLoaderService.new.call
    return unless result.success?

    File.open(dump_path, "wb") { |f| f.write(Marshal.dump(result.success)) }
  end
end
