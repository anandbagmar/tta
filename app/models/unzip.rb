class Unzip
  def self.copy_and_extract_files (input_file_path, output_file_path, test_report_type)
    FileUtils.cp input_file_path, output_file_path
    file_hash = Hash.new
    # puts "copy_and_extract_files: input_file_path: #{input_file_path}, output_file_path: #{output_file_path}, test_report_type: #{test_report_type}"
    Zip::File.open(output_file_path) do |zipFile|
      # puts "zipfile: #{zipFile}"
      zipFile.each do |entry|
        next if entry.name =~ /__MACOSX/ or entry.name =~ /\.DS_Store/ or !entry.file? or (!entry.name.include? ".#{test_report_type}")
        file_hash[entry.to_s]= zipFile.read entry
      end
    end
    return file_hash
  end
end
