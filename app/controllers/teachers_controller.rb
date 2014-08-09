class TeachersController < ApplicationController

  before_action :disallow_logged_in_teacher, only: [:new, :create]

  def index

    @teachers = Teacher.all
    
  end

  def show

  end 

  def new
    @teacher = Teacher.new
  end

  def create

    @teacher = Teacher.new(teacher_params)
    if @teacher.save
      redirect_to dashboard_path, :notice => "Sign up successful.  Welcome to Schologue!"
    else
      render "new"
    end

  end

  def dashboard
  end


  def edit
  end



  def teacher_params
    params.require(:teacher).permit(:teachername, :email, :password, :password_confirmation)
  end

end
