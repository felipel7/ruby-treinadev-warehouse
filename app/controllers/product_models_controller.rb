class ProductModelsController < ApplicationController
  def index
    @product_models = ProductModel.all
  end

  def new
    @product_model = ProductModel.new
    @suppliers = Supplier.all
  end

  def create
    @product_model = ProductModel.new(product_model_params)

    if @product_model.save
      flash[:notice] = "Modelo de produto cadastrado com sucesso."
      redirect_to @product_model # => show
    else
      flash.now[:alert] = "Não foi possível cadastrar o modelo de produto."
      @suppliers = Supplier.all
      render :new
    end
  end

  def show
    @product_model = ProductModel.find(params[:id])
  end

  private

  def product_model_params
    params.require(:product_model).permit(
      :name,
      :height,
      :width,
      :depth,
      :weight,
      :sku,
      :supplier_id
    )
  end
end
