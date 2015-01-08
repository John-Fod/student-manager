class PeriodsController < ApplicationController

  before_action :require_logged_in_teacher, only: [:new, :create, :edit, :update, :delete, :destroy]
  before_action :set_school, only: [:show, :new, :create, :edit, :update, :delete, :destroy]
  before_action :require_valid_school_editor, only: [:new, :create, :edit, :update, :delete, :destroy]
  before_action :set_period, only: [:show, :edit, :update, :destroy, :delete]

  # GET /periods
  # GET /periods.json
  def index
    @periods = Period.all
  end

  # GET /periods/1
  # GET /periods/1.json
  def show
  end

  # GET /periods/new
  def new
    @period = Period.new
    @period.school = @school
  end

  # GET /periods/1/edit
  def edit
  end

  # POST /periods
  # POST /periods.json
  def create
    @period = Period.new(period_params)

    respond_to do |format|
      if @period.save
        format.html { redirect_to @period.school, notice: 'Period was successfully created.' }
        format.json { render :show, status: :created, location: @period.school }
      else
        format.html { render :new }
        format.json { render json: @period.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /periods/1
  # PATCH/PUT /periods/1.json
  def update
    respond_to do |format|
      if @period.update(period_params)
        format.html { redirect_to school_period_path(@period.school, @period), notice: 'Period was successfully updated.' }
        format.json { render :show, status: :ok, location: school_period_path(@period.school, @period) }
      else
        format.html { render :edit }
        format.json { render json: @period.errors, status: :unprocessable_entity }
      end
    end
  end

  def delete

  end

  # DELETE /periods/1
  # DELETE /periods/1.json
  def destroy
    @period.destroy
    respond_to do |format|
      format.html { redirect_to @period.school, notice: 'Period was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_period
      redirect_to @school, :alert => "That period does not exist." unless @period = @school.periods.find_by_id(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def period_params
      params.require(:period).permit(:name, :start_at, :end_at, :school_id)
    end



    def set_school
      unless @school = get_school
        redirect_to dashboard_path, :alert => "That school does not exist."
      end
    end
    

    def require_valid_school_editor
      unless @school.editable_by? current_teacher
        redirect_to dashboard_path, :alert => "You do not have permission to edit that school."
      end
    end



    # WORKERS

    def get_school
      if @period&&@period.school
        return @period.school
      elsif ((params[:school_id])&&(school=School.find_by_id(params[:school_id])))
        return school
      else
        return false
      end        
    end

end
