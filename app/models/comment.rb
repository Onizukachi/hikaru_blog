# frozen_string_literal: true

class Comment < ApplicationRecord
  include ActionView::RecordIdentifier
  include Authorship

  belongs_to :commentable, polymorphic: true
  belongs_to :user
  has_many :likes, as: :likeable, dependent: :destroy

  validates :body, presence: true, length: { minimum: 4 }

  after_commit :broadcast_comment_count

  def for?(commentable)
    commentable = commentable.object if commentable.decorated?

    commentable == self.commentable
  end

  private

  def broadcast_comment_count
    broadcast_update_to 'comment_count', target: dom_id(commentable, 'comments_count'),
                                         html: commentable.comments.size.to_s
  end
end
