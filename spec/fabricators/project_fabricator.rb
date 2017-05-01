Fabricator(:project) do
  name {
    Fabricate.sequence(:name) do |i|
      "Project #{i}"
    end
  }
end