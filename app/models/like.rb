# frozen_string_literal: true

class Like < ApplicationRecord
  belongs_to :user
  belongs_to :likeable, polymorphic: true

  validates :user, uniqueness: { scope: :likeable, message: 'already liked this entity!' }
end
