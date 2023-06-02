# frozen_string_literal: true

class CreatePollingAnswers < ActiveRecord::Migration[7.0]
  def change
    create_table :polling_answers, id: :uuid do |t|
      t.references :polling, null: false, foreign_key: true, type: :uuid
      t.string :description
      t.integer :amount, default: 0, null: false

      t.timestamps
    end
  end
end
