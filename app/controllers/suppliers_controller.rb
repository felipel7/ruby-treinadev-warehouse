class SuppliersController < ApplicationController
  def index
    @suppliers = Supplier.all
  end

  def show
  end
end
