class WarehousesController < ApplicationController
  before_action :set_warehouse, only: [:show, :edit, :update, :destroy]

  def show; end

  def new
    @warehouse = Warehouse.new
  end

  def create
    @warehouse = Warehouse.new(warehouse_params)

    if @warehouse.save
      # There is no view here
      flash[:notice] = "Galpão cadastrado com sucesso."
      redirect_to root_path
    else
      flash.now[:notice] = "Galpão não cadastrado."
      render :new
    end
  end

  def edit; end

  def update
    if @warehouse.update(warehouse_params)
      flash[:notice] = "Galpão atualizado com sucesso."
      redirect_to warehouse_path(@warehouse)
    else
      flash.now[:notice] = "Não foi possível atualizar o galpão."
      render :edit
    end
  end

  def destroy
    @warehouse.destroy
    flash[:notice] = "Galpão removido com sucesso."
    redirect_to root_path
  end

  private

  def set_warehouse
    @warehouse = Warehouse.find(params[:id])
  end

  def warehouse_params
    params.require(:warehouse).permit( # Strong Parameters
      :name,
      :code,
      :city,
      :description,
      :address,
      :cep,
      :area
    )
  end
end
