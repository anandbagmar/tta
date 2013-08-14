module CompareRunsCustomMatchers
    RSpec::Matchers.define :contain_all do |expected|
    	match do |actual|
    		(actual.length == expected.length ) and (actual.to_set == expected.to_set)
    	end
    end

    RSpec::Matchers.define :contain_none_of do |expected|
        match do |actual|
            expected & actual == []
        end
    end
end