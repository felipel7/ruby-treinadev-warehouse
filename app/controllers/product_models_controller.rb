class ProductModelsController < ApplicationController
  def index
    @products = ProductModel.all
  end
end
