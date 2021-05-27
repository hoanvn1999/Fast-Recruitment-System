class Admin::FieldsController < ApplicationController
  before_action :get_field, only: [:update, :destroy]
  before_action :get_fields

  def index
    @field = Field.new
  end

  def create
    field = Field.new field_params
    respond_to do |format|
      if field.save
        format.js {}
      else
        format.html do
          flash[:danger] = t "field.create_fail"
          redirect_to admin_fields_path
        end
      end
    end
  end

  def update
    respond_to do |format|
      if @field.update field_params
        format.js {}
      else
        format.html do
          flash[:danger] = t "field.nil"
          redirect_to admin_fields_path
        end
      end
    end
  end

  def destroy
    respond_to do |format|
      @field.destroy
      format.js {}
    rescue StandardError
      format.html do
        flash[:danger] = t "field.nil"
        redirect_to admin_fields_path
      end
    end
  end

  private

  def get_fields
    @fields = Field.find_field params[:field_name]
    return if @fields

    flash[:danger] = t "field.nil"
    redirect_to admin_fields_path
  end

  def get_field
    @field = Field.find_by id: params[:id]
    return if @field

    flash[:danger] = t "field.nil"
    redirect_to admin_fields_path
  end

  def field_params
    params.require(:field).permit :field_name
  end
end
