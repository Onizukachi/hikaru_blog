# frozen_string_literal: true

class AddMissingNull < ActiveRecord::Migration[7.1]
  def change
    change_column_null :questions, :title, false
    change_column_null :questions, :body, false
    change_column_null :answers, :body, false
  end
end
