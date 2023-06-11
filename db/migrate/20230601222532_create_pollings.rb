# frozen_string_literal: true

class CreatePollings < ActiveRecord::Migration[7.0]
  def change
    create_table :pollings, id: :uuid do |t|
      t.references :user, null: false, foreign_key: true, type: :uuid
      t.string :title
      t.timestamp :duration

      t.timestamps
    end
  end
end
