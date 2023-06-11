# frozen_string_literal: true

class UserPollingController < ApplicationController
  def form
    code = params[:code]
    @polling = Polling.find_by(code:)
    if code.nil? || @polling.nil? || REDIS_CONN.get("#{request.remote_ip}::#{@polling.id}").eql?('true')
      # if code.nil? || @polling.nil?
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
      # if polling_answer.nil?
      respond_to do |format|
        format.html { redirect_to user_status_pollings_url, alert: 'Polling not found!' }
      end
    else
      REDIS_CONN.incr(answer_id)
      if polling_answer.update(amount: REDIS_CONN.get(answer_id))
        polling_id = polling_answer.polling_id
        send_broadcast_action_cable!(polling_id, get_all_amount(polling_id))
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

  private

  def get_all_amount(polling_id)
    answer_polling_amount = Polling.find(polling_id).polling_answers.pluck(:id).map do |polling_answer_id|
      { polling_answer_id:, amount: REDIS_CONN.get(polling_answer_id).to_i }
    end
    { total: answer_polling_amount.pluck(:amount).sum, data: answer_polling_amount }
  end

  def send_broadcast_action_cable!(polling_id, data)
    ActionCable.server.broadcast("pollings_#{polling_id}", data)
  end
end
