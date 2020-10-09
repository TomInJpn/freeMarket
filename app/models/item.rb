class Item < ApplicationRecord
  validates :user_id,:images,:name,:description,:category,:condition,:shipment_fee_id,:shipment_region_id,:shipment_schedule_id,presence: true
  validates :images, presence: true
  validates :name, presence: true, length: { maximum: 40 }
  validates :description, presence: true, length: { maximum: 1000 }
  validates :category, numericality:{other_than: 0, message: "「選択してください」以外を選択してください"}
  validates :condition, numericality:{other_than: 0, message: "「選択してください」以外を選択してください"}
  extend ActiveHash::Associations::ActiveRecordExtensions
    belongs_to :user, optional: true
    belongs_to_active_hash :shipment_fee
    validates :shipment_fee_id, numericality:{other_than: 0, message: "「選択してください」以外を選択してください"}
    belongs_to_active_hash :shipment_region
    validates :shipment_region_id, numericality:{other_than: 0, message: "「選択してください」以外を選択してください"}
    belongs_to_active_hash :shipment_schedule
    validates :shipment_schedule_id, numericality:{other_than: 0, message: "「選択してください」以外を選択してください"}
  validates :price,  presence: true, numericality:{greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999, message: "300〜9,999,999円以内で入力してください"}

  has_many :images
  accepts_nested_attributes_for :images, allow_destroy: true

end