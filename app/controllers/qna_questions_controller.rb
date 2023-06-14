# frozen_string_literal: true

class QnaQuestionsController < ApplicationController
  def form
    code = params[:code]
    @room = QnaRoom.find_by(code:)
    respond_to do |format|
      format.html { render 'qna_questions/form' }
    end
  end

  def ask_question
    @room = QnaRoom.find_by(id: params['room_id'])
    @question = QnaQuestion.new(qna_room_id: @room.id, question: params['question'])
    if @question.save
      respond_to do |format|
        format.html { redirect_to qna_questions_form_url(code: @room.code), notice: 'Success post Question!' }
      end
    else
      respond_to do |format|
        format.html { redirect_to qna_questions_form_url(code: @room.code), alert: 'Failed post Question!' }
      end
    end
  end
end
