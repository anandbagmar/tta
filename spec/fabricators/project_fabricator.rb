Fabricator(:project) do
  name {   Fabricate.sequence(:name) { |i| "Project #{i}" }  }
end