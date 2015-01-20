#encoding: utf-8

class ShipmentsController < ApplicationController
  before_action :logged_in_user

  # index action
  def index
    page = page_ix_help(params[:page])
    # get shipment data list with pagination.
    @shipments = Shipment.paginate(page: page, per_page: 15)
  end

  # show action
  def show
    # get shipment data by shipment_id.
    @shipment = Shipment.find(params[:shipment_id])
    # get shipment detail data by shipment_id
    @shipment_details = ShipmentDetail.where(shipment_id: params[:shipment_id])
  end

  # new action
  def new
    @shipment = Shipment.new
    shipmethod_hash
  end

  # create action
  def create
    @shipment = Shipment.new(shipment_params)
    if @shipment.save
      flash[:success] = "作成完了しました。"
      # shipment list
      redirect_to shipments_path
    else
      shipmethod_hash
      render 'new'
    end
  end

  # edit action
  def edit
    @shipment = Shipment.find(params[:shipment_id])
    shipmethod_hash
  end

  # update action
  def update
    @shipment = Shipment.find(params[:shipment_id])
    if @shipment.update_attributes(shipment_params)
      flash[:success] = "更新完了しました。"
      redirect_to shipments_path
    else
      shipmethod_hash
      render 'edit'
    end
  end

  # destroy action
  def destroy
    Shipment.find(params[:shipment_id]).destroy
    flash[:success] = "削除完了しました。"
    redirect_to shipments_path
  end

  private
    # strong parameters method.
    def shipment_params
      params.require(:shipment).permit(
        :shipmethod_id,
        :sent_date,
        :arrived_date,
        :memo)
    end

    # shipmethod hash method
    def shipmethod_hash
      @shipmethods = {"" => "(空白)"}
      Shipmethod.where(shipmethod_type: 1).each do |ss| 
        @shipmethods.merge! ss.as_hash
      end
    end
end
