class TeachersController < ApplicationController

  before_action :set_teacher, only: [:show, :edit, :update, :delete, :destroy]
  before_action :require_logged_in_teacher, only: [:dashboard, :edit, :update]
  before_action :disallow_logged_in_teacher, only: [:new, :create]
  before_action :require_valid_teacher_editor, only: [:edit, :update, :delete, :destroy]

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
      session[:teacher_id] = @teacher.id
      redirect_to dashboard_path, :notice => "Sign up successful.  Welcome to Academer!"
    else
      render "new"
    end

  end

  def dashboard
    @teacher_schools = current_teacher.founded_schools
  end


  def edit
  end

  def update
    respond_to do |format|
      if @teacher.update(teacher_params)
        format.html { redirect_to dashboard_path, notice: 'Teacher was successfully updated.' }
        format.json { render :show, status: :ok, location: dashboard_path }
      else
        format.html { render :edit }
        format.json { render json: @teacher.errors, status: :unprocessable_entity }
      end
    end
  end



  def teacher_params
    params.require(:teacher).permit(:name, :email, :password, :password_confirmation)
  end

  #-SET TEACHER
  def set_teacher
    unless @teacher = Teacher.find_by_id(params[:id])
      redirect_to teachers_path, :alert => "That teacher can not be found."
    end
  end


  #------------------
  #------METHODS-----
  #------------------

  def require_valid_teacher_editor
    unless @teacher.editable_by? current_teacher
      redirect_to home_path, :alert => "You do not have permission to edit that teacher."
    end
  end

end
