class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_order_and_check_user, only: [:show, :edit, :update, :delivered, :canceled]

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
    set_order_and_check_user
  end

  def edit
    set_order_and_check_user

    @warehouses = Warehouse.all
    @suppliers = Supplier.all
  end

  def update
    set_order_and_check_user

    if @order.update(order_params)
      flash[:notice] = "Pedido atualizado com sucesso."
      redirect_to @order
    else
      @warehouses = Warehouse.all
      @suppliers = Supplier.all
      flash.now[:alert] = "Não foi possível atualizar o pedido."
      render :new
    end
  end

  def search
    @code = params["query"]
    # @order = Order.find_by(code: @code)
    @orders = Order.where("code LIKE ?", "%#{@code}%")
  end

  def delivered
    @order.delivered!
    redirect_to @order
  end

  def canceled
    @order.canceled!
    redirect_to @order
  end

  private

  def order_params
    params.require(:order).permit(
      :warehouse_id, :supplier_id, :estimated_delivery_date
    )
  end

  def set_order_and_check_user
    @order = Order.find(params[:id])

    if @order.user != current_user
      flash[:alert] = "Você não possui acesso a esse pedido."
      return redirect_to root_path
    end
  end
end
