# frozen_string_literal: true

module Admin
  module UserHelper
    def user_roles
      User.roles.keys.map do |role|
        [role.titleize, role]
      end
    end
  end
end
