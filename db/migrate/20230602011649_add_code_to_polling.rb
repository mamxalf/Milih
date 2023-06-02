# frozen_string_literal: true

class AddCodeToPolling < ActiveRecord::Migration[7.0]
  def change
    add_column :pollings, :code, :string, unique: true, null: false, default: -> { 'md5((random())::text)' }
  end
end
