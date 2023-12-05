# frozen_string_literal: true

class QuestionPolicy < ApplicationPolicy
  def like?
    !user.guest? && !user.is_banned
  end

  def unlike?
    like?
  end

  def show?
    true
  end

  def index?
    true
  end

  def create?
    !user.guest?
  end

  def update?
    user.author?(record) || user.admin_role? || user.moderator_role?
  end

  def destroy?
    user.author?(record) || user.admin_role?
  end
end
