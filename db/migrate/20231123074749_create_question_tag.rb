class CreateQuestionTag < ActiveRecord::Migration[7.1]
  def change
    create_table :question_tags do |t|
      t.references :question, null: false, foreign_key: true
      t.references :tag, null: false, foreign_key: true

      t.timestamps
    end

    add_index :question_tags, %i[question_id tag_id], unique: true
  end
end
