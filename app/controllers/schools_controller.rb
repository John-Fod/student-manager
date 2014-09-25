class SchoolsController < ApplicationController

  before_action :set_school, only: [:show, :edit, :update, :delete, :destroy]
  before_action :require_logged_in_teacher, only: [:new, :create, :edit, :update, :delete, :destroy]
  before_action :require_valid_school_editor, only: [:edit, :update, :delete, :destroy]

  # GET /schools
  # GET /schools.json
  def index
    @schools = School.all
  end

  # GET /schools/1
  # GET /schools/1.json
  def show
    @school_students = @school.students.order(:name => :asc)
    @school_rooms = @school.rooms
    @school_periods = @school.periods.order(:start_at => :asc)
  end

  # GET /schools/new
  def new
    @school = School.new
    @school.headmaster = current_teacher
  end

  # GET /schools/1/edit
  def edit
  end

  # POST /schools
  # POST /schools.json
  def create
    @school = School.new(school_params)
    #-ADD THE HEADMASTER TO THE LIST OF THE SCHOOL'S TEACHERS
    @school.teachers<<@school.headmaster

    respond_to do |format|
      if @school.save

        format.html { redirect_to @school, notice: 'School founding successful.' }
        format.json { render :show, status: :created, location: @school }
      else
        format.html { render :new }
        format.json { render json: @school.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /schools/1
  # PATCH/PUT /schools/1.json
  def update
    respond_to do |format|
      if @school.update(school_params)
        format.html { redirect_to @school, notice: 'School update successful.' }
        format.json { render :show, status: :ok, location: @school }
      else
        format.html { render :edit }
        format.json { render json: @school.errors, status: :unprocessable_entity }
      end
    end
  end

  def delete

  end

  # DELETE /schools/1
  # DELETE /schools/1.json
  def destroy
    @school.destroy
    respond_to do |format|
      format.html { redirect_to schools_url, notice: 'School deletion successful.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_school
      @school = School.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def school_params
      params.require(:school).permit(:headmaster_id, :name, :summary, :student_count)
    end

    def require_valid_school_editor
      unless @school.editable_by? current_teacher
        redirect_to schools_path, :alert => "You do not have permission to edit that school."
      end
    end

end
