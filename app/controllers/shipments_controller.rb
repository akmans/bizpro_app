#encoding: utf-8

class ShipmentsController < ApplicationController
  before_action :logged_in_user

  # index action
  def index
    # page index
    page = page_ix_help(params[:page])
    # get shipment data list with pagination.
#    @shipments = Shipment.paginate(page: page, per_page: 15)
    # refresh search condition
    @condition = refresh_shipments_search_condition_help(params)
    # get custom data list with pagination.
    @shipments = search_shipment(@condition, page)
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
#    shipmethod_hash
  end

  # create action
  def create
    @shipment = Shipment.new(shipment_params)
    if @shipment.save
      flash[:success] = "作成完了しました。"
      # shipment list
      redirect_to shipments_path
    else
#      shipmethod_hash
      render 'new'
    end
  end

  # edit action
  def edit
    @shipment = Shipment.find(params[:shipment_id])
#    shipmethod_hash
  end

  # update action
  def update
    @shipment = Shipment.find(params[:shipment_id])
    if @shipment.update_attributes(shipment_params)
      flash[:success] = "更新完了しました。"
      redirect_to shipments_path
    else
#      shipmethod_hash
      render 'edit'
    end
  end

  # destroy action
  def destroy
    Shipment.find(params[:shipment_id]).destroy
    flash[:success] = "削除完了しました。"
    redirect_to shipments_path
  end

  # search action
  def search
    # get parameters from params and save it into session
    @condition = refresh_shipments_search_condition_help(params)
    # get custom data list with pagination.
    @shipments = search_shipment(@condition, 1)
    # render index page
    render 'index'
  end

  private
    # strong parameters method.
    def shipment_params
      params.require(:shipment).permit(:shipmethod_id, :sent_date, :arrived_date, :memo)
    end

#    # shipmethod hash method
#    def shipmethod_hash
#      @shipmethods = {"" => "(空白)"}
#      Shipmethod.where(shipmethod_type: 1).each do |ss| 
#        @shipmethods.merge! ss.as_hash
#      end
#    end

  # search shipment
  def search_shipment(condition, page_ix)
    # construct where condition
    shipment = Shipment
    # shipmethod_id
    shipment = shipment.where(shipmethod_id: condition["shipmethod_id"]) \
              unless condition["shipmethod_id"].blank?
#    debugger
    # product_name
    shipment = shipment.where(shipment_id: ShipmentDetail.where(product_id: \
               Product.where("product_name like :product_name", \
               {:product_name => "%#{condition['product_name']}%"}) \
               .pluck(:product_id)).pluck(:shipment_id)) \
               unless condition["product_name"].blank?
    # start year month
    if !condition["year_s"].blank? && !condition["month_s"].blank? && !condition["date_type"].blank?
      date_s = Date::strptime(condition["year_s"] + condition["month_s"].to_s.rjust(2, '0') + "01", "%Y%m%d")
      # condition for sent date
      shipment = shipment.where("sent_date >= :sent_date", {:sent_date => date_s}) \
                 if condition["date_type"] == "0"
      # condition for arrived date
      shipment = shipment.where("arrived_date >= :arrived_date", {:arrived_date => date_s}) \
                 if condition["date_type"] == "1"
    end
    # end year month
    if !condition["year_e"].blank? && !condition["month_e"].blank? && !condition["date_type"].blank?
      date_e = Date::strptime(condition["year_e"] + condition["month_e"].to_s.rjust(2, '0') + "01", "%Y%m%d")
      # condition for sent date
      shipment = shipment.where("sent_date <= :sent_date", {:sent_date => date_e.end_of_month}) \
                 if condition["date_type"] == "0"
      # condition for arrived date
      shipment = shipment.where("arrived_date <= :arrived_date", {:arrived_date => date_s.end_of_month}) \
                 if condition["date_type"] == "1"
    end
    # date type
    if condition["year_e"].blank? && condition["month_e"].blank? && !condition["date_type"].blank? \
        && condition["year_s"].blank? && condition["month_s"].blank?
      shipment = shipment.where.not(sent_date: nil) if condition["date_type"] == '0'
      shipment = shipment.where.not(arrived_date: nil) if condition["date_type"] == '1'
    end
    # shipment_status
    shipment = shipment.where(arrived_date: nil) if condition["shipment_status"] == '0'
    shipment = shipment.where.not(arrived_date: nil) if condition["shipment_status"] == '1'
    # paginate
    shipment.paginate(page: page_ix, per_page: 15)
  end
end
