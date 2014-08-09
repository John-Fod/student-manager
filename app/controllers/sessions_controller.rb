class SessionsController < ApplicationController

  before_action :disallow_logged_in_teacher, only: [:new, :create]

  def new

  end



  def create
  	
  	teacher = Teacher.authenticate(params[:email], params[:password])

  	if teacher
  		session[:teacher_id] = teacher.id
  		redirect_to dashboard_path, :notice => "Login successful."
  	else
  		flash.now.alert = "Invalid email or password."
  		render "new"
  	end

  end

  def destroy
    if current_teacher
      session[:teacher_id] = nil
      redirect_to home_path, :notice => "Logout successful."
    else
      redirect_to login_path, :alert => "You must be logged in to do that."
    end
  end



end
