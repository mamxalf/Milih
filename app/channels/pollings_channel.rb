# frozen_string_literal: true

class PollingsChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'pollings'
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
