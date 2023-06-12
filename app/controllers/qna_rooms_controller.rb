# frozen_string_literal: true

class QnaRoomsController < ApplicationController
  before_action :authenticate_user!

  layout 'dashboard'

  before_action :set_qna_room, only: %i[show edit update destroy]

  rescue_from ActiveRecord::RecordNotFound, with: :handle_record_not_found

  # GET /qna_rooms
  def index
    @pagy, @qna_rooms = pagy(QnaRoom.where(user_id: current_user.id).order(created_at: :desc))
  end

  # GET /qna_rooms/1
  def show
  end

  # GET /qna_rooms/new
  def new
    @qna_room = QnaRoom.new
  end

  # GET /qna_rooms/1/edit
  def edit
  end

  # POST /qna_rooms
  def create
    @qna_room = QnaRoom.new(qna_room_params)

    if @qna_room.save
      redirect_to @qna_room, notice: 'Qna room was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /qna_rooms/1
  def update
    if @qna_room.update(qna_room_params)
      redirect_to @qna_room, notice: 'Qna room was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /qna_rooms/1
  def destroy
    @qna_room.destroy
    redirect_to qna_rooms_url, notice: 'Qna room was successfully destroyed.', status: :see_other
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_qna_room
    @qna_room = QnaRoom.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def qna_room_params
    params['qna_room']['duration'] = Time.parse(params['qna_room']['duration']).utc unless params['qna_room']['duration'].empty?
    params.require(:qna_room).permit(:title, :description, :duration).merge(user_id: current_user.id)
  end
end
