Fabricator(:product) do
  name {
    Fabricate.sequence(:name) do |i|
      "Product #{i}"
    end
  }
end