class SuppliersController < ApplicationController
  before_action :set_supplier, only: [:show, :create]

  def index
    @suppliers = Supplier.all
  end

  def show; end

  def new
    @supplier = Supplier.new
  end

  def create
    @supplier = Supplier.new(supplier_params)

    if @supplier.save
      flash[:notice] = "Fornecedor salvo com sucesso."
      redirect_to supplier_path
    else
      flash.now[:notice] = "Não foi possível salvar o fornecedor."
      render :new
    end
  end

  private

  def set_supplier
    @supplier = Supplier.find(params[:id])
  end

  def supplier_params
    params.require(:supplier).permit(
      :corporate_name,
      :brand_name,
      :registration_number,
      :full_address,
      :city,
      :state,
      :email
    )
  end
end
