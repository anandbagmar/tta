
 module Domain
  module Upload_dataDomain
     def upload_the_data(table)
       table.hashes.each do |row|
         navigate_to_homepage
         navigate_to_upload_page
         upload_data_and_submit(row)
         verify_data_uploaded(UPLOAD_SUCCESS)
       end
     end

     def verify_data_uploaded(proj_succ)
       assert page_has_content?(proj_succ),"No Project uploaded"
     end

   end
 end

World(Domain::Upload_dataDomain)
