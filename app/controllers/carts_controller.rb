require 'aws-sdk-s3'

class CartsController < ApplicationController

  def index
    render json: Cart.all
  end

  def show
    render json: Cart.find(params[:id])
  end

  def create
    render json: Cart.create(cart_params)
  end

  def update
    cart = Cart.find(params[:id])
    render json: cart.update(cart_params)
  end

  def destroy
    render json: Cart.destroy(params[:id])
  end

  def export_cart_csv
    cart = Cart.all
    object_key = cart.to_csv
    storage_container = StorageContainer.new

    respond_to do |format|
      csv_data = cart.to_csv
      file_name = "carts-#{Time.now.to_i}.csv"

      if storage_container.async.object_uploaded?(file_name, csv_data)
        puts "File named '#{object_key}' was uploaded successfully."
      else
        puts "File named '#{object_key}' failed to upload."
      end

      format.html
      format.csv { send_data csv_data, filename: file_name }
    end

  end

  def export_cart_by_email_csv
    cart = Cart.where(email: params[:email])
    object_key = cart.to_csv
    storage_container = StorageContainer.new

    respond_to do |format|
      csv_data = cart.to_csv
      file_name = "cart-#{Time.now.to_i}.csv"

      if storage_container.async.object_uploaded?(file_name, csv_data)
        puts "File named '#{object_key}' was uploaded successfully."
      else
        puts "File named '#{object_key}' failed to upload."
      end

      format.html
      format.csv { send_data csv_data, filename: file_name }
    end
  end

  def add_product_to_cart
    cart = Cart.eager_load(:products).where(email: params[:email]).first
    cart.products << Product.find(params[:product_id])

    render :json => cart.to_json(:include => :products)
  end

  def delete_product_from_cart
    cart = Cart.eager_load(:products).where(email: params[:email]).first
    product = Product.find(params[:product_id])
    cart.products.delete(product)

    render :json => cart.to_json(:include => :products)
  end

  def get_cart_by_email
    cart = Cart.eager_load(:products).where(email: params[:email]).first

    render :json => cart.to_json(:include => :products)
  end

  private
    def cart_params
      params.require(:cart).permit(:email)
    end
end