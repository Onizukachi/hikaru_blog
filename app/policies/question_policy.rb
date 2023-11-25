# frozen_string_literal: true
#
class QuestionPolicy < ApplicationPolicy
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
