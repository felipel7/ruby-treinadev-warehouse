class Api::V1::WarehousesController < ActionController::API
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

    begin
      warehouse = Warehouse.find(params[:id])
      render status: 200, json: warehouse.as_json(except: [:created_at, :updated_at])
    rescue => exception
      render status: 404
    end
  end
end
