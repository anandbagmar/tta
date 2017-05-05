class Product < ActiveRecord::Base
  has_many :platforms
  attr_accessible :name
  before_validation :uppercase_name
  validates_uniqueness_of :name, :case_sensitive => false
  validates_presence_of :name

  scope :get_all_products, -> {
    Product.all
  }

  def add_platform(params)
    platforms.where(name: (params[:platform_name]).split.join(" ").upcase).first_or_create
  end

  private
    def uppercase_name
        self.name.upcase! if !self.name.nil?
    end
end
