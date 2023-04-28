class OrdersController < ApplicationController
  before_action :authenticate_user!

  def index
    @orders = current_user.orders
  end

  def new
    @order = Order.new
    @warehouses = Warehouse.all
    @suppliers = Supplier.all
  end

  def create
    @order = Order.new(order_params)
    @order.user = current_user

    if @order.save
      flash[:notice] = "Pedido registrado com sucesso."
      redirect_to @order
    else
      @warehouses = Warehouse.all
      @suppliers = Supplier.all
      flash.now[:alert] = "Não foi possível registrar o pedido."
      render :new
    end
  end

  def show
    @order = Order.find(params[:id])
  end

  def search
    @code = params["query"]
    # @order = Order.find_by(code: @code)
    @orders = Order.where("code LIKE ?", "%#{@code}%")
  end

  private

  def order_params
    params.require(:order).permit(
      :warehouse_id, :supplier_id, :estimated_delivery_date
    )
  end
end
