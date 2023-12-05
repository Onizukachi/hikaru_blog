# frozen_string_literal: true

class Like < ApplicationRecord
  include ActionView::RecordIdentifier

  belongs_to :user
  belongs_to :likeable, polymorphic: true

  validates :user, uniqueness: { scope: :likeable, message: 'already liked this entity!' }

  after_commit :broadcast_like_count

  private

  def broadcast_like_count
    broadcast_replace_to 'likes', partial: 'shared/like_count', target: dom_id(likeable, :like_count),
                                  locals: { object: likeable }
  end
end
