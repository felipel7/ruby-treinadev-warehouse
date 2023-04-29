class OrderItemsController < ApplicationController
  def new
    @order = Order.find(params[:order_id])
    @order_item = OrderItem.new
    @products = @order.supplier.product_models
  end

  def create
    @order = Order.find(params[:order_id])
    order_item_params = params.require(:order_item).permit(
      :product_model_id,
      :quantity
    )

    @order.order_items.create(order_item_params)
    # @order_item = OrderItem.new(order_item_params)
    # @order_item.order = @order
    # @order_item.save
    flash[:notice] = "Item adicionado com sucesso"
    redirect_to @order
  end
end
