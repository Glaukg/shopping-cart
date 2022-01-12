class Cart < ApplicationRecord
  has_and_belongs_to_many :products
  validates :email, presence: true, uniqueness: true

  def self.to_csv(options = {})
    attributes = %w{id email products}

    CSV.generate(headers: true) do |csv|
      csv << attributes

      all.each do |cart|
        products = ""
        cart.products.each do |prod|
          products << "Name: #{prod.name}, price: #{ prod.price }$, discount: #{prod.discount}, description: #{prod.description} \n"
        end
        csv << [cart.id, cart.email, products]
      end
    end
  end
end
