class TimeClocksController < ApplicationController
  before_action :set_time_clock, only: [ :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /time_clocks
  # GET /time_clocks.json
  def index
    @time_clocks = current_user.time_clocks
    @total_hours = 0
    @time_clocks.each do |time|
      if time.clock_out.nil?
      else
        time.hours = time_diff(time.clock_in, time.clock_out)
        @total_hours += time.hours.round
      end
    end
  end

  # GET /time_clocks/1
  # GET /time_clocks/1.json

  # GET /time_clocks/new
  def new
    @time_clock = TimeClock.new
  end

  # GET /time_clocks/1/edit
  def edit
  end

  # POST /time_clocks
  # POST /time_clocks.json
  def create
    @time_clock = TimeClock.new(time_clock_params)
    @time_clock.user_id = current_user.id.to_i
    @time_clock.save!

    if current_user.teacher?
      @time_clock.clock_in = round_time(Time.now).strftime("%k:%M:%S")
      @time_clock.clock_in = @time_clock.clock_in - 5.hours
      @time_clock.save!
    else
      @time_clock.clock_in = Time.now.strftime("%k:%M:%S")
      @time_clock.clock_in = @time_clock.clock_in - 5.hours
      @time_clock.save!
    end

    respond_to do |format|
      if @time_clock.save
        format.html { redirect_to root_path, notice: 'Time clock was successfully created.' }
        format.json { render :show, status: :created, location: @time_clock }
      else
        format.html { render :new }
        format.json { render json: @time_clock.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /time_clocks/1
  # PATCH/PUT /time_clocks/1.json
  def update
    @time_clock = TimeClock.find(params[:id])
    if current_user.hotlineteacher? || current_user.teacher?
      @time_clock.clock_out = round_time(Time.now).strftime("%k:%M:%S")
      @time_clock.clock_out = @time_clock.clock_out - 5.hours
      @time_clock.save!
    else
      @time_clock.clock_out = Time.now.strftime("%k:%M:%S")
      @time_clock.clock_out = @time_clock.clock_out - 5.hours
      @time_clock.save!
    end
    @time_clock.billed = 0
    @time_clock.save!
    respond_to do |format|
      if @time_clock.update(time_clock_params)
        format.html { redirect_to root_path, notice: 'Time clock was successfully updated.' }
        format.json { render :show, status: :ok, location: @time_clock }
      else
        format.html { render :edit }
        format.json { render json: @time_clock.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /time_clocks/1
  # DELETE /time_clocks/1.json
  def destroy
    @time_clock.destroy
    respond_to do |format|
      format.html { redirect_to time_clocks_url, notice: 'Time clock was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_time_clock
      @time_clock = TimeClock.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def time_clock_params
      params.require(:time_clock).permit(:clock_in, :clock_out, :date, :hours, :billed, :mnps_report_id)
    end
end
