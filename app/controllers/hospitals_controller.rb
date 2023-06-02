require_relative '../queries/hospital_query'
class HospitalsController < ApplicationController
  before_action :set_hospital, only: %i[ show edit update destroy ]

  # GET /hospitals or /hospitals.json
  def index
    if params[:name] || params[:address] || params[:phone] || params[:street]
      @hospitals = HospitalQuery.new(params[:name], params[:address], params[:phone], params[:street]).call.page(params[:page])
    else
      @hospitals = Hospital.all.page(params[:page])
    end
  end

  # GET /hospitals/1 or /hospitals/1.json
  def show
  end

  # GET /hospitals/new
  def new
    @hospital = Hospital.new
  end

  # GET /hospitals/1/edit
  def edit
  end

  # POST /hospitals or /hospitals.json
  def create
    @hospital = Hospital.new(hospital_params)

    respond_to do |format|
      if @hospital.save
        @hospital.avatar.attach(params[:avatar]) if params[:avatar].present?
        format.html { redirect_to hospital_url(@hospital), notice: "Hospital was successfully created." }
        format.json { render :show, status: :created, location: @hospital }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @hospital.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /hospitals/1 or /hospitals/1.json
  def update
    respond_to do |format|
      if @hospital.update(hospital_params)
        format.html { redirect_to hospital_url(@hospital), notice: "Hospital was successfully updated." }
        format.json { render :show, status: :ok, location: @hospital }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @hospital.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /hospitals/1 or /hospitals/1.json
  def destroy
    @hospital.destroy

    respond_to do |format|
      format.html { redirect_to hospitals_url, notice: "Hospital was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_hospital
    @hospital = Hospital.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def hospital_params
    params.require(:hospital).permit(:name, :address, :phone, :street, :avatar)
  end
end
