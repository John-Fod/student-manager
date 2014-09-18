class StudentsController < ApplicationController
  
  before_action :require_logged_in_teacher, only: [:new, :create, :edit, :update, :delete, :destroy]
  before_action :set_school
  before_action :require_valid_school_editor, only: [:new, :create, :edit, :update, :delete, :destroy]
  before_action :set_student, only: [:show, :edit, :update, :delete, :destroy]

  # GET /students
  # GET /students.json
  def index
    @students = Student.all
  end

  # GET /students/1
  # GET /students/1.json
  def show
    @student_schools = @student.schools.order(:name => :asc)
  end

  # GET /students/new
  def new
    @student = Student.new unless @student
    @student.school = @school
  end

  # GET /students/1/edit
  def edit
  end

  # POST /students
  # POST /students.json
  def create
    @student = Student.new(student_params)

    respond_to do |format|
      if @student.save

        #-CONNECT THE SCHOOL AND THE STUDENT IF @school IS PRESENT
        @student.schools << @school if @school

        format.html { redirect_to school_student_path(@student.school,@student), notice: 'Student creation successful.' }
        format.json { render :show, status: :created, location: @student }
      else
        format.html { render :new }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /students/1
  # PATCH/PUT /students/1.json
  def update
    respond_to do |format|
      if @student.update(student_params)
        format.html { redirect_to school_student_path(@student.school,@student), notice: 'Student update successful.' }
        format.json { render :show, status: :ok, location: @student }
      else
        format.html { render :edit }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  def delete

  end

  # DELETE /students/1
  # DELETE /students/1.json
  def destroy
    @student.destroy
    respond_to do |format|
      format.html { redirect_to @student.school, notice: 'Student deletion successful.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_student
      unless @student = @school.students.find_by_id(params[:id])
        redirect_to @school, :alert => "That student does not exist."
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def student_params
      params.require(:student).permit(:name, :about, :level, :school_id, :room_ids => [])
    end

    def set_school
      unless @school = get_school
        redirect_to schools_path, :alert => "That school does not exist."
      end
    end

    def require_valid_school_editor
      if @school
        unless @school.editable_by? current_teacher
          redirect_to @school, :alert => "You do not have permission to edit that school."
        end
      end
    end



    # WORKERS

    def get_school
      if ((params[:school_id])&&(school=School.find_by_id(params[:school_id])))
        return school
      else
        return false
      end        
    end

end
