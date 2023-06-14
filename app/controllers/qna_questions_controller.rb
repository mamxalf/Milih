# frozen_string_literal: true

class QnaQuestionsController < ApplicationController
  def form
    code = params[:code]
    @qna_room = QnaRoom.find_by(code:)
    if code.nil? || @qna_room.nil?
      respond_to do |format|
        format.html { redirect_to user_status_pollings_url, alert: 'QnA not found!' }
      end
    else
      render 'qna_questions/form'
    end
  end

  def ask_question
  end
end
