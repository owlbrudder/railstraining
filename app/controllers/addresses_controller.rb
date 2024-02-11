class AddressesController < ApplicationController
  before_action :set_address, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, except: [:index, :show, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]

  # GET /addresses or /addresses.json
  def index
    # @addresses = Address.all
    @addresses = Address.where("user_id = #{current_user.id}")
  end

  # GET /addresses/1 or /addresses/1.json
  def show
    @addresses = Address.where("user_id = #{current_user.id}")
  end

  # GET /addresses/new
  def new
    # @address = Address.new
    @address = current_user.addresses.build
  end

  # GET /addresses/1/edit
  def edit
  end

  # POST /addresses or /addresses.json
  def create
    # @address = Address.new(address_params)
    @address = current_user.addresses.build(address_params)

    respond_to do |format|
      if @address.save
        format.html { redirect_to address_url(@address), notice: "Address was successfully created." }
        format.json { render :show, status: :created, location: @address }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @address.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /addresses/1 or /addresses/1.json
  def update
    respond_to do |format|
      if @address.update(address_params)
        format.html { redirect_to address_url(@address), notice: "Address was successfully updated." }
        format.json { render :show, status: :ok, location: @address }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @address.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /addresses/1 or /addresses/1.json
  def destroy
    @address.destroy

    respond_to do |format|
      format.html { redirect_to addresses_url, notice: "Address was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def correct_user
    @address = current_user.addresses.find_by(id: params[:id])
    redirect_to addresses_path, notice: "Not authorised to deal with that record" if @address.nil?
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_address
      @address = Address.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def address_params
      params.require(:address).permit(:number, :street, :suburb, :city, :state, :postcode, :country, :user_id)
    end
end
