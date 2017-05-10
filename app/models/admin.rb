class Admin < ActiveRecord::Base

  def self.create_result_json(products)
    json=Hash.new
    if (products.none?)
      json["message"]="No Products Using TTA"
    else
      products.each do |product|
        key           =product.id
        json[key]     =[]
        platform_data = product.platforms.select("name , product_id , id")
        json[key].push("product_name" => product.name)
        platform_name=[]
        test_count   =[]

        platform_data.each do |data|
          platform_name.push(data.name)
          test_count.push(data.test_metadatum.length)
        end

        json[key].push("platforms" => platform_name)
        json[key].push("test_count" => test_count)
      end
    end
    return json
  end

  def self.get_result_json(products= {})
    @json =create_result_json(products)
    @json = @json.to_json
    @json
  end

  def self.add_external_dashboard(external_dashboard_name, external_dashboard_link)
    ExternalDashboard.find_or_create_by(name: external_dashboard_name, link: external_dashboard_link)

  end

  def self.update_external_dashboard_link(external_dashboard_name, external_dashboard_link)
    ExternalDashboard.find_by_name(external_dashboard_name).update_column("link", external_dashboard_link)
  end
end
