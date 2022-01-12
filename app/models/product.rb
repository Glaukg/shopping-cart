class Product < ApplicationRecord
  has_and_belongs_to_many :carts
  validates :name, presence: true, uniqueness: true
  validates :price, presence: true

  def self.to_csv
    attributes = %w{id name price discount description}

    CSV.generate(headers: true) do |csv|
      csv << attributes

      all.each do |product|
        csv << product.attributes.values_at(*attributes)
      end

    end

  end
end
