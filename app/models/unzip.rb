class Unzip
  def self.copy_and_extract_files (input_file_path, output_file_path)
    FileUtils.cp input_file_path, output_file_path
    file_hash = Hash.new()
    Zip::ZipFile.open(output_file_path) do |zipFile|
      zipFile.each do |entry|
        file_hash[entry.to_s]=zipFile.read(entry)
      end
      return file_hash
    end
  end
end
