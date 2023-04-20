class WarehousesController < ApplicationController
  def show
    @warehouse = Warehouse.find(params[:id])
  end

  def new
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

    warehouse = Warehouse.new(warehouse_params)

    if warehouse.save
      # There is no view here
      redirect_to root_path
    end
  end
end
