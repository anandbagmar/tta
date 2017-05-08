#module Support
#  module FileUtils
def absolute_path (*args)
  File.expand_path(File.join(args.each { |f| f }))
end
#end
#end

#World(Support::FileUtils)