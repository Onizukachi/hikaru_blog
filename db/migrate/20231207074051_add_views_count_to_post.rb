class AddViewsCountToPost < ActiveRecord::Migration[7.1]
  def change
    add_column :questions, :views_count, :integer, default: 0
  end
end
