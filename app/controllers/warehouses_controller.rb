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
end
