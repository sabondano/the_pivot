class ProductsController < ApplicationController
  def index
    @categories = Category.all
    @products = Product.paginate(:page => params[:page], :per_page => 20)
    filtering_params(params).each do |key, value|
      @products = @products.public_send(key, value) if value.present?
    end
  end

  def show
    load_featured_products
    @product = Product.find(params[:id])
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    flash[:success] = "Successfully deleted product."
    redirect_to products_path
  end

  private

  def filtering_params(params)
    params.slice(:category_id)
  end
end
