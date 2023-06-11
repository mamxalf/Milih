# frozen_string_literal: true

module ApplicationHelper
  include Pagy::Frontend

  def seconds_to_hms(duration)
    sec = duration - Time.zone.now
    return 'Time is Over' if sec.negative?

    format('%<hours>02d:%<minutes>02d:%<seconds>02d', hours: sec / 3600, minutes: sec / 60 % 60, seconds: sec % 60)
  end
end
