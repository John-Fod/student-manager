class SessionsController < ApplicationController

  before_action :disallow_logged_in_teacher, only: [:new, :create]

  def new

  end



  def create
  	
  	teacher = Teacher.authenticate(params[:email], params[:password])

  	if teacher
  		session[:teacher_id] = teacher.id
  		redirect_to dashboard_path, :notice => "You are now logged in."
  	else
  		flash.now.alert = "Invalid email or password"
  		render "new"
  	end

  end


  def destroy
  	session[:teacher_id] = nil
  	redirect_to home_path, :notice => "You are now logged out"
  end



end
