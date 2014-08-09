class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  


  private


  #- Get the current teacher if there is one logged in
  def current_teacher
  	@current_teacher ||= Teacher.find(session[:teacher_id]) if session[:teacher_id]
  end
  helper_method :current_teacher


  #- Send a teacher to the dashboard if they are logged in
  def disallow_logged_in_teacher alert="You must first log out to do that."
  	if current_teacher
  		redirect_to dashboard_path, :alert => "#{alert}"
  	end
  end
  helper_method :disallow_logged_in_teacher

end
