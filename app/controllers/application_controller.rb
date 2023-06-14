# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pagy::Backend

  def handle_record_not_found
    respond_to do |format|
      format.html { redirect_to pollings_url, alert: 'Data Not Found!' }
    end
  end
end
