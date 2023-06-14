# frozen_string_literal: true

class QnaQuestion < ApplicationRecord
  after_create_commit { broadcast_prepend_to qna_room_id, locals: { room: qna_room, qna: self } }

  belongs_to :qna_room
end
