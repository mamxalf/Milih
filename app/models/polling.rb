# frozen_string_literal: true

class Polling < ApplicationRecord
  before_create :generate_code
  after_create_commit { broadcast_prepend_to user_id }

  has_many :polling_answers, dependent: :destroy

  private

  def generate_code
    loop do
      self.code = SecureRandom.alphanumeric(5)
      break unless self.class.exists?(code:)
    end
  end
end
