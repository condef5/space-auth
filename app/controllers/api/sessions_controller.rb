module Api
  class SessionsController < BaseController
    skip_before_action :require_login, only: :create

    def create
      user = User.login?(params[:email], params[:password])
      if user
        user.regenerate_token
        render json: { token: user.token }
      else
        render_unauthorized('Incorrect email or password')
      end
    end

    def destroy
      current_user.invalidate_token
      head :ok
    end
  end
end
