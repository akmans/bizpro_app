#encoding: utf-8
class ShipmentDetailsController < ApplicationController
  before_action :logged_in_user
  before_action :set_shipment_details, only: [:edit, :update, :destroy]
  before_action :all_shipment_details, only: [:index, :create, :update, :destroy]
  respond_to :html, :js

#  def index
#    # shipment detail data with pagination
#    @shipment_details = ShipmentDetail.where(shipment_id: params[:shipment_shipment_id])
#              .paginate(page: params[:page], :per_page => 15)
#  end

#  # show action
#  def show
#    @shipment_detail = ShipmentDetail.find(params[:id])
#  end

  # new action
  def new
    @shipment = Shipment.find(params[:shipment_shipment_id])
#    debugger
    # shipment_detail instance
    @shipment_detail = ShipmentDetail.new
#    @shipment_detail.shipment_id = params[:shipment_shipment_id]
  end

  def create
    @shipment_detail = ShipmentDetail.new(shipment_detail_params)
    @shipment_detail.shipment_id = params[:shipment_shipment_id]
    if @shipment_detail.save
      flash.now[:success] = "作成完了しました。"
#      # shipment detail list
#      redirect_to shipment_shipment_details_path
    else
      render 'new'
    end
  end

  # edit action
  def edit
    @shipment = Shipment.find(params[:shipment_shipment_id])
    @shipment_detail = ShipmentDetail.find(params[:id])
  end

  # upadte action
  def update
    @shipment = Shipment.find(params[:shipment_shipment_id])
    @shipment_detail = ShipmentDetail.find(params[:id])
    if @shipment_detail.update_attributes(shipment_detail_params)
      flash.now[:success] = "更新完了しました。"
#      redirect_to shipment_shipment_details_path
    else
      render 'edit'
    end
  end

  # destroy action
  def destroy
    ShipmentDetail.find(params[:id]).destroy
    flash.now[:success] = "削除完了しました。"
#    redirect_to shipment_shipment_details_path
  end

  private
    # all shipment_details
    def all_shipment_details
      @shipment_details = ShipmentDetail.where(shipment_id: params[:shipment_shipment_id])
    end

    # set shipment_details
    def set_shipment_details
      @shipment_detail = ShipmentDetail.find(params[:id])
    end

    # strong parameters method.
    def shipment_detail_params
      params.require(:shipment_detail).permit(
        :product_id,
        :ship_cost,
        :insured_cost,
        :custom_cost,
        :memo)
    end
end
