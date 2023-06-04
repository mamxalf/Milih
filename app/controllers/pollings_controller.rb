# frozen_string_literal: true

class PollingsController < ApplicationController
  layout 'dashboard'

  before_action :set_polling, only: %i[show edit update destroy]

  # GET /pollings or /pollings.json
  def index
    @pagy, @pollings = pagy(Polling.includes([:polling_answers]).where(user_id: current_user.id).order(created_at: :desc))
  end

  # GET /pollings/1 or /pollings/1.json
  def show
  end

  # GET /pollings/new
  def new
    @polling = Polling.new
  end

  # GET /pollings/1/edit
  def edit
  end

  # POST /pollings or /pollings.json
  def create
    ActiveRecord::Base.transaction do
      @polling = Polling.create!(polling_params)
      polling_answers = params[:polling_answers].compact_blank.map do |answer|
        { polling_id: @polling.id, description: answer }
      end
      PollingAnswer.insert_all!(polling_answers) # rubocop:disable Rails/SkipsModelValidations
    end
    respond_to do |format|
      format.html { redirect_to polling_url(@polling), notice: 'Polling was successfully created.' }
      format.json { render :show, status: :created, location: @polling }
    end
  rescue ActiveRecord::Rollback => e
    respond_to do |format|
      format.html { render :new, status: :unprocessable_entity }
      format.json { render json: e, status: :unprocessable_entity }
    end
  end

  # PATCH/PUT /pollings/1 or /pollings/1.json
  def update
    respond_to do |format|
      if @polling.update(polling_params)
        format.html { redirect_to polling_url(@polling), notice: 'Polling was successfully updated.' }
        format.json { render :show, status: :ok, location: @polling }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @polling.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pollings/1 or /pollings/1.json
  def destroy
    @polling.destroy

    respond_to do |format|
      format.html { redirect_to pollings_url, notice: 'Polling was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_polling
    @polling = Polling.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def polling_params
    params.require(:polling).permit(:title, :duration).merge(user_id: current_user.id)
  end
end
