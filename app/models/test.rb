.main
%section.main__block
  = form_with model:@item, local:true do |f|
    %h2.sell__block__head
      商品の情報を入力
    .sell__block__form
      .sell__block__form__upload
        %h3.sell__block__form__upload__head
          出品画像
          %span.require 必須
        %p 最大5枚までアップロードできます
        .post__drop__box__container
          .prev-content
          .label-content
            %label{for: "item_images_attributes_0_image", class: "abel-box", id: "label-box--0"}
              %pre.label-box__text-visible クリックしてファイルをアップロード
          .hidden-content
            = f.fields_for :images do |i|
              = i.file_field :image, class: "hidden-field"
              %input{class:"hidden-field", type: "file", name: "item[images_attributes][1][image]", id: "item_images_attributes_1_image" }
              %input{class:"hidden-field", type: "file", name: "item[images_attributes][2][image]", id: "item_images_attributes_2_image" }
              %input{class:"hidden-field", type: "file", name: "item[images_attributes][3][image]", id: "item_images_attributes_3_image" }
              %input{class:"hidden-field", type: "file", name: "item[images_attributes][4][image]", id: "item_images_attributes_4_image" }
      .sell__block__form__name
        .form-group__name
          %label
            商品名
            %span.require 必須
          %div
            = f.text_field :name, placeholder:"商品名（必須 40文字まで)",class: "form__group__name"

      .sell__block__form__btn
        %div
          = f.submit "出品する",class: "btn-default__btn-red"