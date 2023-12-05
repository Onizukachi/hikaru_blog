# frozen_string_literal: true

class CommentPolicy < ApplicationPolicy
  def like?
    !user.guest? && !user.is_banned
  end

  def unlike?
    like?
  end

  def index?
    true
  end

  def show?
    !user.guest?
  end

  def create?
    !user.guest? && !user.is_banned
  end

  def update?
    user.admin_role? || user.moderator_role? || (user.author?(record) && !user.is_banned)
  end

  def destroy?
    user.admin_role? || (user.author?(record) && !user.is_banned)
  end
end
