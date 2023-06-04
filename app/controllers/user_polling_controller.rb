# frozen_string_literal: true

class UserPollingController < ApplicationController
  def form
    code = params[:code]
    @polling = Polling.find_by(code:)
    if code.nil? || @polling.nil?
      render 'user_polling/not_found'
    else
      render 'user_polling/form'
    end
  end
end
