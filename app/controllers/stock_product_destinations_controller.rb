class StockProductDestinationsController < ApplicationController
  def create
    warehouse = Warehouse.find(params[:warehouse_id])
    product_model = ProductModel.find(params[:product_model_id])

    stock_product = StockProduct.find_by(warehouse: warehouse, product_model: product_model)

    if stock_product != nil
      flash[:notice] = "Item retirado com sucesso"

      stock_product.create_stock_product_destination!(
        recipient: params[:recipient],
        address: params[:address],
      )
      redirect_to warehouse
    end
  end
end
