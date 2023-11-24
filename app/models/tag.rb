# frozen_string_literal: true

class Tag < ApplicationRecord
  validates :title, presence: true, uniqueness: true
  has_many :question_tags, dependent: :destroy
  has_many :questions, through: :question_tags

  def self.search(params)
    if params[:query].blank?
      all
    else
      where(
        'title LIKE ?', "%#{sanitize_sql_like(params[:query])}%"
      )
    end
  end
end
