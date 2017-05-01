class Unzip
  def self.copy_and_extract_files (input_file_path, output_file_path)
    FileUtils.cp input_file_path, output_file_path
    file_hash = Hash.new
    Zip::File.open(output_file_path) do |zipFile|
      zipFile.each do |entry|
        next if entry.name =~ /__MACOSX/ or entry.name =~ /\.DS_Store/ or !entry.file?
        file_hash[entry.to_s]= zipFile.read entry
      end
    end
    return file_hash
  end
end
