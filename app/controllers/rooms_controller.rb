class RoomsController < ApplicationController

  before_action :set_room, only: [:show, :edit, :update, :destroy]
  before_action :set_school
  before_action :require_logged_in_teacher, only: [:new, :create, :edit, :update, :delete, :destroy]
  before_action :require_valid_school_editor, only: [:edit, :update, :delete, :destroy]

  # GET /rooms
  # GET /rooms.json
  def index
    @rooms = Room.all
  end

  # GET /rooms/1
  # GET /rooms/1.json
  def show
  end

  # GET /rooms/new
  def new
    @room = Room.new
    @room.school = @school
    @room.founding_teacher = current_teacher
  end

  # GET /rooms/1/edit
  def edit
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
        format.html { redirect_to school_room_path(@room.school,@room), notice: 'Room was successfully updated.' }
        format.json { render :show, status: :ok, location: @room }
      else
        format.html { render :edit }
        format.json { render json: @room.errors, status: :unprocessable_entity }
      end
    end
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
      unless @school = School.find_by_id(params[:school_id])
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
      params.require(:room).permit(:name, :summary, :school_id, :founding_teacher_id)
    end
end
