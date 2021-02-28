module Api
  class BaseController < ApplicationController
    before_action :require_login

    def require_login
      authenticate || render_unauthorized('Access denied')
    end

    def current_user
      @current_user ||= authenticate
    end

    private

    def render_unauthorized(message)
      errors = { errors: { message: message } }
      render json: errors, status: :unauthorized
    end

    def authenticate
      authenticate_or_request_with_http_token do |token, _options|
        User.find_by(token: token)
      end
    end
  end
end
