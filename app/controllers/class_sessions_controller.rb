class ClassSessionsController < ApplicationController
  before_action :require_logged_in_teacher, only: [:new, :create, :edit, :update, :delete, :destroy]
  before_action :set_class_session, only: [:show, :edit, :update, :destroy]
  before_action :set_school, except: [:index]
  before_action :require_valid_school_editor, only: [:new, :create, :edit, :update, :delete, :destroy]
  before_action :set_room, except: [:index]

  # GET /class_sessions
  # GET /class_sessions.json
  def index
    @class_sessions = ClassSession.all
  end

  # GET /class_sessions/1
  # GET /class_sessions/1.json
  def show
  end

  # GET /class_sessions/new
  def new
    @class_session = ClassSession.new
    @class_session.school = @school
    @class_session.room = @room if @room

    if @room
      @potential_students = @room.students + (@school.students.order(:name => :asc) - @room.students)
      @room.students.each do |student|
        @class_session.students << student
      end
    else
      @potential_students = @class_session.school.students
    end

  end

  # GET /class_sessions/1/edit
  def edit

    if @class_session.room
      @potential_students = @class_session.room.students + (@school.students.order(:name => :asc) - @class_session.room.students)
    else
      @potential_students = @class_session.school.students
    end

  end

  # POST /class_sessions
  # POST /class_sessions.json
  def create
    @class_session = ClassSession.new(class_session_params)

    if ((@class_session.room) && (@class_session.quick_creation==true))
      @class_session.room.students.each do |student|
        @class_session.students << student
      end
    end

    respond_to do |format|
      if @class_session.save
        format.html { redirect_to school_path(@class_session.school, :day => @class_session.day), notice: 'Class session was successfully created.' }
        format.json { render :show, status: :created, location: @class_session.school }
      else

        if @class_session.room
          @potential_students = @class_session.room.students + (@school.students.order(:name => :asc) - @class_session.room.students)
          @class_session.room.students.each do |student|
          @class_session.students << student
        end
      else
        @potential_students = @class_session.school.students
      end

        format.html { render :new }
        format.json { render json: @class_session.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /class_sessions/1
  # PATCH/PUT /class_sessions/1.json
  def update
    respond_to do |format|
      if @class_session.update(class_session_params)
        format.html { redirect_to school_class_session_path(@class_session.school, @class_session), notice: 'Class session was successfully updated.' }
        format.json { render :show, status: :ok, location: @class_session }
      else
        format.html { render :edit }
        format.json { render json: @class_session.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /class_sessions/1
  # DELETE /class_sessions/1.json
  def destroy
    @class_session.destroy
    respond_to do |format|
      format.html { redirect_to school_path(@class_session.school), notice: 'Class session was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_class_session
      @class_session = ClassSession.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def class_session_params
      params.require(:class_session).permit(
        :room_id,
        :teacher_id,
        :status,
        :school_id,
        :name,
        :summary,
        :held_at,
        :day,
        :period_id,
        :quick_creation,
        :student_ids => [])
    end

    def set_school
      unless @school = School.find_by_id(params[:school_id])
        redirect_to dashboard_path, :alert => "That school does not exist."
      end
    end

    def set_room
      if params[:room_id]
        unless @room = @school.rooms.find_by_id(params[:room_id])
          redirect_to school_path(@school), :alert => "That room does not exist."
        end
      end
    end

    #WORKERS

    def get_school
      if @class_session&&@class_session.school
        return @class_session.school
      elsif ((params[:school_id])&&(school=School.find_by_id(params[:school_id])))
        return school
      else
        return false
      end        
    end

    def require_valid_school_editor
      unless @school.editable_by? current_teacher
        redirect_to dashboard_path, :alert => "You do not have permission to edit that school."
      end
    end


end
