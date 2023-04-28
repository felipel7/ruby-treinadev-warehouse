# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

User.create!([
  { name: "Felipe", email: "felipe@gmail.com", password: "123123" },
  { name: "Maria", email: "maria@gmail.com", password: "123123" },
  { name: "Joao", email: "joao@gmail.com", password: "123123" },
])

Supplier.create!([
  {
    corporate_name: "ACME",
    brand_name: "ACME LTDA",
    registration_number: "70.000.000/0000-0",
    full_address: "Av. Main Street",
    city: "Curitiba",
    state: "PR",
    email: "example@gmail.com",
  },
  {
    corporate_name: "LG",
    brand_name: "LG Corporation",
    registration_number: "71.000.100/0000-1",
    full_address: "Av. Ver. Manoel Antunes",
    city: "Cabo Frio",
    state: "RJ",
    email: "exampleLg@gmail.com",
  },
  {
    corporate_name: "Samsung",
    brand_name: "Samsung Corporation",
    registration_number: "11.030.100/0502-2",
    full_address: "Av. Cásper Líbero",
    city: "São Paulo",
    state: "SP",
    email: "samsung@gmail.com",
  },
])

Warehouse.create!([
  {
    name: "Aeroporto SP",
    code: "GRU",
    city: "Guarulhos",
    area: 10000,
    address: "Avenida do Aeroporto, 1000",
    cep: "15000-000",
    description: "Galpão destinado para cargas internacionais",
  },
  {
    name: "Aeroporto Rio",
    code: "SDU",
    city: "Rio de Janeiro",
    area: 8000,
    address: "Rua Alberto Santos Dumont, 768",
    cep: "21000-000",
    description: "Galpão destinado para cargas",
  },
  {
    name: "Aeroporto Curitiba",
    code: "CWB",
    city: "Curitiba",
    area: 11000,
    address: "Rua Afonso Pena, 111",
    cep: "41020-000",
    description: "Galpão destinado para cargas internacionais",
  },
])

ProductModel.create!([
  {
    name: "Samsung Galaxy S21 Ultra",
    weight: 227,
    width: 7,
    height: 10,
    depth: 10,
    sku: "SGS21ULTRA-BLK",
    supplier_id: 3,
  },
  {
    name: "Samsung 55-Inch QLED 4K Smart TV",
    weight: 3950,
    width: 120,
    height: 70,
    depth: 12,
    sku: "QLED55-SRTTV-22",
    supplier_id: 3,
  },
  {
    name: "LG 65-inch 4K Smart OLED TV",
    weight: 2400,
    width: 144,
    height: 83,
    depth: 11,
    sku: "OLED65CX-SRTTV-22",
    supplier_id: 2,
  },
  {
    name: "LG Gram 17-inch Laptop",
    weight: 3350,
    width: 38,
    height: 26,
    depth: 12,
    sku: "LGRAM17-LAPTOP-23",
    supplier_id: 2,
  },
  {
    name: "ACME Super Zoom Camera",
    weight: 1640,
    width: 10,
    height: 7,
    depth: 13,
    sku: "ACME-SZC-2023",
    supplier_id: 1,
  },
  {
    name: "ACME High-Powered Blender",
    weight: 2100,
    width: 19,
    height: 44,
    depth: 24,
    sku: "ACME-HPB-2023",
    supplier_id: 1,
  },
])

Order.create!([
  {
    warehouse_id: 2,
    supplier_id: 3,
    user_id: 1,
    code: "UMYMCKLZ",
    estimated_delivery_date: 10.days.from_now,
  },
  {
    warehouse_id: 1,
    supplier_id: 2,
    user_id: 1,
    code: "UJMDSD70",
    estimated_delivery_date: 6.days.from_now,
  },
  {
    warehouse_id: 2,
    supplier_id: 1,
    user_id: 3,
    code: "KPJWCD22",
    estimated_delivery_date: 5.days.from_now,
  },
  {
    warehouse_id: 3,
    supplier_id: 1,
    user_id: 2,
    code: "BQWSDF31",
    estimated_delivery_date: 1.days.from_now,
  },
  {
    warehouse_id: 1,
    supplier_id: 1,
    user_id: 2,
    code: "XQPLNM89",
    estimated_delivery_date: 13.days.from_now,
  },
  {
    warehouse_id: 3,
    supplier_id: 3,
    user_id: 3,
    code: "KIOKLP12",
    estimated_delivery_date: 3.days.from_now,
  },
])
