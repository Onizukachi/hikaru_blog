# frozen_string_literal: true

class AnswerPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    true
  end

  def update?
    user.author?(record) || user.moderator_role? || user.admin_role?
  end

  def create?
    !user.guest?
  end

  def destroy?
    user.author?(record) || user.admin_role?
  end
end
