class BusinessesController < ApplicationController

  rescue_from ActiveRecord::RecordNotFound, :with => :record_not_found

  def index
    begin
      businesses = Business.page(params[:page]).per(params[:per])
      total_count = Business.page(params[:page]).per(params[:per]).total_count
      json = { page: params[:page] || 1, number_per_page: params[:per] || 50,
        total_count: total_count, businesses: businesses }
      render json: json, status: :ok
    rescue => e
      render :json => { errors: e.message }, status: :bad_request
    end
  end

  def show
    business = Business.find(params[:id])
    render json: business, status: :ok
  end

  private
    def record_not_found(error)
      render :json => {:error => error.message}, :status => :not_found
    end
end
