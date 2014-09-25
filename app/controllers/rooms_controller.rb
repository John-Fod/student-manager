class RoomsController < ApplicationController

  before_action :set_room, only: [:show, :edit, :update, :delete, :destroy]
  before_action :set_school
  before_action :require_logged_in_teacher, only: [:new, :create, :edit, :update, :delete, :destroy]
  before_action :require_valid_school_editor, only: [:new, :create, :edit, :update, :delete, :destroy]

  # GET /rooms
  # GET /rooms.json
  def index
    @rooms = Room.all
  end

  # GET /rooms/1
  # GET /rooms/1.json
  def show
    @room_students = @room.students
  end

  # GET /rooms/new
  def new
    @room = Room.new
    @room.school = @school
    @room.founding_teacher = current_teacher
    @school_periods = @school.periods.order(:start_at => :asc)
    @school_teachers = @school.teachers.order(:name => :asc)
  end

  # GET /rooms/1/edit
  def edit
    @school_periods = @school.periods.order(:start_at => :asc)
    @school_teachers = @school.teachers.order(:name => :asc)
  end

  # POST /rooms
  # POST /rooms.json
  def create
    @room = Room.new(room_params)

    respond_to do |format|
      if @room.save
        format.html { redirect_to school_room_path(@room.school,@room), notice: 'Room founding successful.' }
        format.json { render :show, status: :created, location: @room }
      else
        format.html { render :new }
        format.json { render json: @room.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rooms/1
  # PATCH/PUT /rooms/1.json
  def update
    respond_to do |format|
      if @room.update(room_params)
        format.html { redirect_to school_room_path(@room.school,@room), notice: 'Room update successful.' }
        format.json { render :show, status: :ok, location: @room }
      else
        format.html { render :edit }
        format.json { render json: @room.errors, status: :unprocessable_entity }
      end
    end
  end

  def delete

  end

  # DELETE /rooms/1
  # DELETE /rooms/1.json
  def destroy
    @room.destroy
    respond_to do |format|
      format.html { redirect_to school_rooms_path(@room.school), notice: 'Room was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_room
      unless @room = Room.find_by_id(params[:id])
        redirect_to home_path, :alert => "That room does not exist."
      end
    end

    def set_school
      unless @school = get_school
        redirect_to schools_path, :alert => "That school does not exist."
      end
    end

    def require_valid_school_editor
      unless @school.editable_by? current_teacher
        redirect_to schools_path, :alert => "You do not have permission to edit that school."
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def room_params
      params.require(:room).permit(
        :name,
        :summary,
        :school_id,
        :founding_teacher_id,
        :regular_day,
        :regular_period,
        :student_ids => []
      )
    end


    # WORKERS

    def get_school
      if @room&&@room.school
        return @room.school
      elsif ((params[:school_id])&&(school=School.find_by_id(params[:school_id])))
        return school
      else
        return false
      end        
    end

end
