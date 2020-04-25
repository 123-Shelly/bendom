class Item < ApplicationRecord
	validates :name, presence: true
	validates :price, presence: true, 
	                  numericality: { greater_than: 0 }

  belongs_to :category
  has_one_attached :cover
  has_many :comments
  has_many :favorite_items
  has_many :users, through: :favorite_items

  # scope :available, -> { where(deleted_at: nil)}

  default_scope {where(deleted_at: nil)}
  # 讓刪除的資料真的找不到
  # 嘗試把東西刪掉，再救回來。4/13 2:35 開始
  # Item.unscope(:where).where.not(delete_at: nil)   unscope 解除預設篩選的功能(終端機)
  # 按刪除後會給時間戳記，執行以上摳會將集間戳記還原成nil，重新整理後東西會回來。
  # Item.all 看共刪除了啥 

  def destroy
  	update(deleted_at: Time.now) 	
  end

  
  def favorited_by(u)
  	u.items.include?(self)

  end


end

# add_column :items, :deleted_at, :datetime
# add_index :items, :deleted_at
