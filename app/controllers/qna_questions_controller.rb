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
  end
end
