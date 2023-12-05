# frozen_string_literal: true

class Answer < ApplicationRecord
  include Authorship
  include Commentable

  belongs_to :user
  belongs_to :question
  has_many :likes, as: :likeable, dependent: :destroy

  validates :body, presence: true, length: { minimum: 5 }
end
