class Api::V1::WarehousesController < Api::V1::ApiController
  def index
    # warehouses = Warehouse.all.order(:name)
    warehouses = Warehouse.all
    render status: 200, json: warehouses.as_json(except: [:created_at, :updated_at])
  end

  def show
    # warehouse = Warehouse.find_by(id: params[:id]) => retorna nil, caso nao exista

    # if warehouse.nil?
    #   render status: 404
    # else
    #   render status: 200, json: warehouse.as_json(except: [:created_at, :updated_at])
    # end

    # begin
    #   warehouse = Warehouse.find(params[:id])
    #   render status: 200, json: warehouse.as_json(except: [:created_at, :updated_at])
    # rescue => exception
    #   render status: 404
    # end

    warehouse = Warehouse.find(params[:id])
    render status: 200, json: warehouse.as_json(except: [:created_at, :updated_at])
  end

  def create
    warehouse_params = params.require(:warehouse).permit(
      :name,
      :code,
      :city,
      :area,
      :address,
      :cep,
      :description
    )

    warehouse = Warehouse.new(warehouse_params)

    if warehouse.save
      render status: 201, json: warehouse
    else
      render status: 412, json: { errors: warehouse.errors.full_messages }
    end
  end
end
