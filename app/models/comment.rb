# frozen_string_literal: true

class Comment < ApplicationRecord
  include Authorship
  belongs_to :commentable, polymorphic: true
  belongs_to :user
  has_many :likes, as: :likeable, dependent: :destroy

  validates :body, presence: true, length: { minimum: 4 }

  def for?(commentable)
    commentable = commentable.object if commentable.decorated?

    commentable == self.commentable
  end
end
