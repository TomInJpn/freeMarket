class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :destroy, :edit, :update]

  def index
    @items = Item.includes(:images).order('created_at DESC').limit(5)
    @parents = Category.where(ancestry: nil)
  end

  def new
    @item = Item.new
    @images = @item.images.build
    @parent_category = Category.where(ancestry: nil)
  end

  def create
    @item = Item.new(item_params)
    if @item.valid? && @item.save!
      redirect_to root_path controller: :items, action: :index
    else
      @parent_category = Category.where(ancestry: nil)
      @item.images.new
      render "new"
    end
  end

  def show
    @parents = Category.where(ancestry: nil)
  end

  def edit
    @item.user_id = current_user.id && user_signed_in?
    @parent_category = Category.where(ancestry: nil)
    @item.images.build
  end

  def update
    if @item.update(item_params)
      redirect_to root_path
    else
      render "edit"
    end
  end


  def get_children
    @categories = Category.where(ancestry: params[:category_id])
    respond_to do |format|
      format.json
    end
  end

  def get_grand_children
    @children_categories = Category.where(ancestry: params[:category_id])
    respond_to do |format|
      format.json
    end
  end


  def destroy
    if @item.user_id == current_user.id && @item.destroy
      redirect_to root_path
    end
  end


  def purchase
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    customer = Payjp::Customer.retrieve(current_user.card.customer_id) if current_user.card
    @card = customer.cards.retrieve(current_user.card.card_id) if current_user.card
    @item = Item.find(params[:id])
    @shipment_fee = ShipmentFee.find(@item.shipment_fee_id)
  end

  def payment
    item = Item.find(params[:id])
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    charge = Payjp::Charge.create(
      amount: item.price.to_i,
      customer: Card.find_by(user_id: current_user.id).customer_id,
      currency: 'jpy'
    )
    if item.update(buyer_id: current_user.id)
      redirect_to root_path
    else
      Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
      customer = Payjp::Customer.retrieve(current_user.card.customer_id) if current_user.card
      @card = customer.cards.retrieve(current_user.card.card_id) if current_user.card
      @item = Item.find(params[:item_id])
      @shipment_fee = ShipmentFee.find(@item.shipment_fee_id)
      render "new"
    end
  end

  private

  def item_params
    params.require(:item).permit(:images, :name, :description, :category, :brand, :condition_id, :shipment_fee_id, :shipment_region_id, :shipment_schedule_id, :price, :category_id, images_attributes: [:src, :id, :_destroy]).merge(user_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def payment_params
    params.permit(
      :item_id,
      :quantity,
    ).merge(user_id: current_user.id)
  end

end

