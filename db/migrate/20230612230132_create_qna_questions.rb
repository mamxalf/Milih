# frozen_string_literal: true

class CreateQnaQuestions < ActiveRecord::Migration[7.0]
  def change
    create_table :qna_questions, id: :uuid do |t|
      t.references :qna_room, null: false, foreign_key: true, type: :uuid
      t.references :user, null: true, foreign_key: true, type: :uuid
      t.text :question
      t.integer :amount, default: 0

      t.timestamps
    end
  end
end
