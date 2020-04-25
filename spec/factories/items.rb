FactoryBot.define do
  factory :item do
  	name { Faker::Name.name}
  	price { Faker::Number.between(from: 50, to: 300)}
  	category
    # 這樣寫就會執行，等於做一個名字叫category的id
  end
end

# FactoryBot工廠名稱叫item，做出餐點名稱跟餐點價錢。
# 在終端機 rails c --sandbox 的環境測試。
