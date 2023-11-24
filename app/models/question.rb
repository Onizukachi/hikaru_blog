# frozen_string_literal: true

class Question < ApplicationRecord
  include Commentable

  belongs_to :user
  has_many :answers, dependent: :destroy
  has_many :question_tags, dependent: :destroy
  has_many :tags, through: :question_tags

  validates :title, presence: true, length: { minimum: 2 }
  validates :body, presence: true, length: { minimum: 2 }

  scope :all_by_tags, lambda { |params|
    questions = includes(:user)

    questions = if params[:query].present?
                  tags = Tag.search params
                  questions.joins(:tags).where(tags:).preload(:tags)
                elsif params.has_key? :tag_ids
                  tags = Tag.where(id: params[:tag_ids])
                  questions.joins(:tags).where(tags:).preload(:tags)
                else
                  questions.includes(:question_tags, :tags)
                end

    questions.order(created_at: :desc)
  }
end
