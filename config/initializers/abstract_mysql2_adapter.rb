# class ActiveRecord::ConnectionAdapters::Mysql2Adapter
#   NATIVE_DATABASE_TYPES[:primary_key] = "int(11) auto_increment PRIMARY KEY"
# end
#

# class ActiveRecord::ConnectionAdapters::Mysql2Adapter
#   def modify_types(types)
#     super
#     types[:primary_key] = "int(11) auto_increment PRIMARY KEY"
#     types
#   end
# end