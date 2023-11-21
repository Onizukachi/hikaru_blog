# frozen_string_literal: true

class Question < ApplicationRecord
  include Commentable

  belongs_to :user
  has_many :answers, dependent: :destroy

  validates :title, presence: true, length: { minimum: 2 }
  validates :body, presence: true, length: { minimum: 2 }
end
