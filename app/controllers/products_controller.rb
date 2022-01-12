require 'aws-sdk-s3'

class ProductsController < ApplicationController

  def index
    render json: Product.all
  end

  def show
    render json: Product.find(params[:id])
  end

  def create
    render json: Product.create(product_params)
  end

  def update
    product = Product.find(params[:id])
    render json: product.update(product_params)
  end

  def destroy
    render json: Product.destroy(params[:id])
  end

  def export_product_csv
    product = Product.all
    object_key = product.to_csv
    storage_container = StorageContainer.new

    respond_to do |format|
      csv_data = product.to_csv
      file_name = "products-#{Time.now.to_i}.csv"

      if storage_container.async.object_uploaded?(file_name, csv_data)
        puts "File named '#{object_key}' was uploaded successfully."
      else
        puts "File named '#{object_key}' failed to upload."
      end

      format.html
      format.csv { send_data csv_data, filename: file_name }
    end
  end

  private

    def product_params
      params.require(:product).permit(:name, :price, :discount, :description)
    end

end
