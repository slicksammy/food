class Packages

  DB_PRODUCTS = [["Ribeye, 10 oz", "0c00a7da-fa7b-44f3-9db7-da23790b8eb1"], 
  ["NY Strip, 10 oz", "f5a08648-f7eb-41f1-b1bf-ed0562227d7d"], 
  ["Bone-In NY Strip, 10 oz", "421b57b1-d258-44e2-9401-c6ae31099627"], 
  ["Dry Aged Ribeye, 10 oz", "ce106aa6-0314-4e4c-a428-1c0b3fbdd2bc"], 
  ["Dry Aged NY Strip, 12 oz", "b515f2f9-f471-4e73-ac38-7288fb804345"], 
  ["Chicken Breast, 6oz", "456fc5f8-e29a-4b84-90c8-a81894708c9d"], 
  ["Chicken Tender, 3oz", "81c20c76-803f-40ee-b53c-ec6fb3834d3b"], 
  ["Filet Mignon, 8 oz", "57d98b21-36b2-4e5a-aac3-8e8b0afe680e"]]

  def self.packages
    [
      { name: 'The Holiday Try It Out',
        products: [ {uuid: "0c00a7da-fa7b-44f3-9db7-da23790b8eb1", amount: 1},
                    {uuid: "f5a08648-f7eb-41f1-b1bf-ed0562227d7d", amount: 1},
                    {uuid: "57d98b21-36b2-4e5a-aac3-8e8b0afe680e", amount: 1},
                  ]
      },
      {
        name: 'The Holiday Sampler',
        products: Product.active.map { |p| {uuid: p.uuid, amount: 1} }
      },
      {
        name: 'The Holiday Feast'
      }
    ]
  end
end
