require "rails_helper"

describe "Update order Request" do
  it "should not allow a user to edit another user's order" do
    user = User.create!(name: "Maria", email: "maria@email.com", password: "123123")
    another_user = User.create!(name: "Felipe", email: "felipe@email.com", password: "123123")

    warehouse = Warehouse.create!(
      name: "Maceio", code: "MCZ",
      city: "Maceio", area: 50_000,
      address: "Av. Main Street", cep: "30000-000",
      description: "Galpão de Maceio",
    )

    supplier = Supplier.create!(
      corporate_name: "ACME", brand_name: "ACME Corporation",
      registration_number: "22.222.222/2222-2",
      full_address: "Av. Main Street, 123", city: "Curitiba",
      state: "PR", email: "example@acme.com",
    )

    order = Order.create!(
      user: user, warehouse: warehouse,
      supplier: supplier, estimated_delivery_date: 1.day.from_now,
    )

    login_as(another_user)
    patch(order_path(order.id), params: { order: { supplier_id: 3 } })

    expect(response).to redirect_to(root_path)
  end
end
