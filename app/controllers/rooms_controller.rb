class RoomsController < ApplicationController

  before_action :require_logged_in_teacher, only: [:new, :create, :edit, :update, :delete, :destroy]
  before_action :set_school
  before_action :require_valid_school_editor, only: [:new, :create, :edit, :update, :delete, :destroy]
  before_action :set_room, only: [:show, :edit, :update, :delete, :destroy]

  # GET /rooms
  # GET /rooms.json
  def index
    @rooms = Room.all
  end

  # GET /rooms/1
  # GET /rooms/1.json
  def show
    @room_students = @room.students
    @recent_class_sessions = @room.class_sessions.where("day < ?", Date.today).order("day DESC").limit(2).reverse
    @upcoming_class_sessions = @room.class_sessions.where("day > ?", Date.today).order("day DESC").limit(5)
    @todays_class_session = @room.class_sessions.where("day = ?", Date.today)
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

        #-MAKE CLASS SESSIONS FOR A YEAR
        if params[:autoschedule_class_sessions] 
          if @room.regular_day && @room.regular_period
            start = Time.now.beginning_of_day
            to = start + params[:auto_schedule_period].to_i.month
            scheduled_class_day = start
            begin
              if scheduled_class_day.wday == @room.regular_day
                new_class_session = ClassSession.new
                new_class_session.school = @room.school
                new_class_session.room = @room
                new_class_session.day = scheduled_class_day.to_date
                new_class_session.period = @room.regular_period
                new_class_session.held_at = @room.regular_period.start_at
                new_class_session.teacher_id = @room.regular_teacher_id if @room.regular_teacher_id
                new_class_session.save
              end
              scheduled_class_day += 1.day
            end while scheduled_class_day <= to
          end
        end

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
      @room.class_sessions.each do |class_session|
        class_session.destroy
      end
      format.html { redirect_to school_rooms_path(@room.school), notice: 'Room was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_room
      unless @room = @school.rooms.find_by_id(params[:id])
        redirect_to school_path(@school), :alert => "That room does not exist."
      end
    end

    def set_school
      unless @school = School.find_by_id(params[:school_id])
        if current_teacher
          redirect_to dashboard_path, :alert => "That school does not exist."
        else
          redirect_to home_path, :alert => "That school does not exis"
        end
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
        :regular_teacher_id,
        :regular_period_id,
        :student_ids => []
      )
    end


    # WORKERS

    def get_school
      if @school
        return @school
      elsif ((params[:school_id])&&(school=School.find_by_id(params[:school_id])))
        return school
      else
        return false
      end        
    end

end
