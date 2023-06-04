# frozen_string_literal: true

class UserPollingController < ApplicationController
  def form
    code = params[:code]
    @polling = Polling.find_by(code:)
    if code.nil? || @polling.nil? || REDIS_CONN.get("#{request.remote_ip}::#{@polling.id}").eql?('true')
      respond_to do |format|
        format.html { redirect_to user_status_pollings_url, alert: 'Polling not found!' }
      end
    else
      render 'user_polling/form'
    end
  end

  def submit
    answer_id = params['answer']
    polling_answer = PollingAnswer.find_by(id: answer_id)
    if polling_answer.nil? || !REDIS_CONN.set("#{request.remote_ip}::#{polling_answer.polling_id}", true, nx: true, ex: 1.day)
      respond_to do |format|
        format.html { redirect_to user_status_pollings_url, alert: 'Polling not found!' }
      end
    else
      REDIS_CONN.incr(answer_id)
      if polling_answer.update(amount: REDIS_CONN.get(answer_id))
        respond_to do |format|
          format.html { redirect_to user_status_pollings_url, notice: 'Thank you for choosing polling.' }
        end
      else
        respond_to do |format|
          format.html { redirect_to user_status_pollings_url, alert: 'Polling not found!' }
        end
      end
    end
  end

  def redirect_status_page
    respond_to do |format|
      format.html { render 'user_polling/status' }
    end
  end
end
