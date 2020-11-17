# README

## 接続先情報
* URL http://54.95.229.43/
* ID/Pass
  * ID: fukuoka77a
  * Pass: lccbata77
* テスト用アカウント等
  * 購入者用
    * メールアドレス: test@test.co.jp
    * パスワード: test123
    * 購入用カード情報
      * 番号： 4242424242424242
      * 期限： 2/22
      * セキュリティコード：222
  * 出品者用
    * メールアドレス名: test@test.com
    * パスワード: test123

## 担当箇所
* ユーザー登録・ログイン（マークアップ・サーバーサイド）
![frema-app](https://user-images.githubusercontent.com/66042540/99434723-70b68900-2952-11eb-87f3-942d45eea29f.gif)
![frema-app](https://user-images.githubusercontent.com/66042540/99434698-6b593e80-2952-11eb-9309-791311affe5e.png)
* 商品購入・クレジットカード登録（サーバーサイド）です。
![frema-app](https://user-images.githubusercontent.com/66042540/99434682-67c5b780-2952-11eb-85b1-82b3bf166f73.png)
## portforio
[Like weeds](https://tominjpn.github.io/portfolio/)

## 本アプリ期間内に制作しました
[個人製作最終課題](https://github.com/TomInJpn/frema-app)

## usersテーブル

|Column|Type|Options|
|------|----|-------|
|nickname|string|null: false|
|email|string|null: false, unique: true|
|encrypted_password|string|null: false|
|family_name_kanji|string|null: false|
|first_name_kanji|string|null: false|
|family_name_kana|string|null: false|
|first_name_kana|string|null: false|
|reset_password_token|string|unique: true|
|reset_password_sent_at|datetime||
|remember_created_at|datetime||

### Association
- has_many :items
- has_one :address
- has_one :card


## addressesテーブル

|Column|Type|Options|
|------|----|-------|
|user_id|references|null: false, foreign_key: true|
|family_name_kanji|string|null: false|
|first_name_kanji|string|null: false|
|family_name_kana|string|null: false|
|first_name_kana|string|null: false|
|post_number|string|null: false|
|prefecture_id|integer|null: false|
|city|string|null: false|
|block_number|string|null: false|
|apartment_name|string||
|phone_number|string||

### Association
- belongs_to :user
- belongs_to :prefecture


## cardsテーブル

|Column|Type|Options|
|------|----|-------|
|user_id|references|null: false, foreign_key: true|
|customer_id|string|null: false|
|card_id|string|null: false|

### Association
- belongs_to :user


## itemsテーブル

|Column|Type|Options|
|------|----|-------|
|user_id|references|null: false, foreign_key: true|
|category_id|references|null: false, foreign_key: true|
|buyer_id|references|null: false, foreign_key: true|
|name|string|null: false|
|price|integer|null: false|
|description|string|null: false|
|brand|string||
|condition_id|integer|null: false|
|shipment_fee_id|integer|null: false|
|shipment_region_id|integer|null: false|
|shipment_schedule_id|integer|null: false|

### Association
- belongs_to :user
- belongs_to :category
- belongs_to :buyer
- has_many :images


## categoriesテーブル

|Column|Type|Options|
|------|----|-------|
|name|string||
|ancestry|string||

### Association
- has_many :items


## imagesテーブル

|Column|Type|Options|
|------|----|-------|
|item_id|references|null: false, foreign_key: true|
|src|string|null: false|

### Association
- belongs_to :item

