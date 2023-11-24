# frozen_string_literal: true

class EditableUser < User
  private

  def validate_correct_old_password?
    false
  end
end
