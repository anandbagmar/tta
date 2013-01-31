
 module Domain
  module Upload_dataDomain

     def upload_the_data(table)
       upload_test_data(table)
     end

    def upload_test_data(table)
      fill_the_form(table)
    end

   end
 end

World(Domain::Upload_dataDomain)
