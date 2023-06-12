# frozen_string_literal: true

class CreateQnaRooms < ActiveRecord::Migration[7.0]
  def change
    create_table :qna_rooms do |t|
      t.references :user, null: false, foreign_key: true, type: :uuid
      t.string :code, :string, unique: true, null: false, default: -> { 'md5((random())::text)' }
      t.string :title
      t.text :description
      t.timestamp :duration

      t.timestamps
    end
  end
end
