# frozen_string_literal: true

class QnaRoom < ApplicationRecord
  before_create :generate_code

  belongs_to :user

  private

  def generate_code
    loop do
      self.code = SecureRandom.alphanumeric(5)
      break unless self.class.exists?(code:)
    end
  end
end
