class Item < ApplicationRecord
  validates :user_id,:images,:name,:description,:category,:condition_id,:shipment_fee_id,:shipment_region_id,:shipment_schedule_id,:price, presence: true
  validates :images, presence: true
  validates :name, presence: true, length: { maximum: 40 }
  validates :description, presence: true, length: { maximum: 1000 }
  # validates :condition, numericality:{other_than: 0, message: "「選択してください」以外を選択してください"}
  extend ActiveHash::Associations::ActiveRecordExtensions
    belongs_to :user, class_name: "User"

    belongs_to_active_hash :condition
    validates :condition_id, numericality:{other_than: 0, message: "「選択してください」以外を選択してください"}
    belongs_to_active_hash :shipment_fee
    validates :shipment_fee_id, numericality:{other_than: 0, message: "「選択してください」以外を選択してください"}
    belongs_to_active_hash :shipment_region
    validates :shipment_region_id, numericality:{other_than: 0, message: "「選択してください」以外を選択してください"}
    belongs_to_active_hash :shipment_schedule
    validates :shipment_schedule_id, numericality:{other_than: 0, message: "「選択してください」以外を選択してください"}
  validates :price, presence: true, numericality:{greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999, message: "300〜9,999,999円以内で入力してください"}

  belongs_to :category
  has_many    :images, dependent: :destroy
  accepts_nested_attributes_for :images, allow_destroy: true
  # belongs_to :buyer, class_name: "User", foreign_key: "buyer_id", optional: true
  belongs_to :buyer, class_name: "User",  optional: true

  # カテゴリーの単体テスト
  # 以下のコメントアウトは今後必要になるかもしれないので残しております
  # validate :category_is_grandchild

  # private

  # def category_is_grandchild
  #   if self.category.children.length != 0
  #     errors.add(:category, "not grandchild")
  #   end
  # end

end