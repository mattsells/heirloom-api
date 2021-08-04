# frozen_string_literal: true

module RequestHelper
  def sign_in(user, password = 'password')
    post v1_user_session_path, params: {
      user: {
        email: user.email, password: password
      }
    }

    byebug
  end
end
