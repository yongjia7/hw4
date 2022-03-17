class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by({email: params["email"]})
    if @user
      if BCrypt::Password.new(@user.password) == params["password"]
        session[:user_id] = @user.id
        flash[:notice] = "Welcome to Tacostagram, #{@user.username}."
        redirect_to "/places"
      else
        flash[:notice] = "Incorrect Password"
        redirect_to "/sessions/new"
      end
    else
      flash[:notice] = "User not found.Please Signup."
      redirect_to "/sessions/new"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to "/sessions/new"
  end
end
  