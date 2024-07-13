class SessionsController < ApplicationController
  def create
    @user = User.find_by(username: params[:user][:username])
    if @user&.authenticate(params[:user][:password])
      session = @user.sessions.create
      cookies.permanent.signed[:todolist_session_token] = {
        value: session.token,
        httponly: true
      }
      render json: {
        success: true,
        username: @user.username
      }
    else
      render json: {
        success: false,
        error: 'Invalid username or password'
      }
    end
  end

  def authenticated
    token = cookies.signed[:todolist_session_token]
    session = Session.find_by(token: token)
    if session
      render json: {
        authenticated: true,
        username: session.user.username
      }
    else
      render json: {
        authenticated: false
      }
    end
  end

  def destroy
    token = cookies.signed[:todolist_session_token]
    session = Session.find_by(token: token)
    if session&.destroy
      render json: {
        success: true
      }
    else
      render json: {
        success: false
      }
    end
  end
end
