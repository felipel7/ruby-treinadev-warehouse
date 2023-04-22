class WarehousesController < ApplicationController
  def show
    @warehouse = Warehouse.find(params[:id])
  end

  def new
    @warehouse = Warehouse.new
  end

  def create
    # params = hash
    warehouse_params = params.require(:warehouse).permit( # Strong Parameters
      :name,
      :code,
      :city,
      :description,
      :address,
      :cep,
      :area
    )

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

  def edit
    @warehouse = Warehouse.find(params[:id])
  end

  def update
    @warehouse = Warehouse.find(params[:id])

    warehouse_params = params.require(:warehouse).permit(
      :name,
      :code,
      :city,
      :description,
      :address,
      :cep,
      :area
    )

    if @warehouse.update(warehouse_params)
      flash[:notice] = "Galpão atualizado com sucesso."
      redirect_to warehouse_path(@warehouse)
    else
      flash.now[:notice] = "Não foi possível atualizar o galpão."
      render :edit
    end
  end
end
