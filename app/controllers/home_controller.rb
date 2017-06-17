class HomeController < ApplicationController
	before_action :authenticate_user!

  def timesheets
    unless current_user.admin?
      redirect_to root_path
    end
    @users = User.all
  end

  def index
    @time_clock = TimeClock.new
    @time = TimeClock.find_by user_id: current_user.id
    @date = Date.parse(Date.today.to_s)
    @current_clock = current_user.time_clocks.where(date: @date)
    @search = Search.new
    @mnps_report = MnpsReport.new
    @users = User.all
    @call_log = CallLog.new
  	if current_user.token.include?("mnps")
  		current_user.role = 2
      current_user.save!
  	end
  	if current_user.token.include?("volunteer")
  		current_user.role = 0
      current_user.save!
  	end
  	if current_user.token.include?("hotline teacher")
      current_user.role = 1
      current_user.save!
    end
    if current_user.token.include?("5h43bf3ff2azce43")
      current_user.role = 3
      current_user.district = "null"
      current_user.save!
    end
    if current_user.admin? && current_user.district != "null"
      @user = User.where(id: current_user.district).first
      @user.role = 3
      @user.token = "5h43bf3ff2azce43"
      @user.district = "null"
      @user.save!
      current_user.district  = "null"
      current_user.save!
    end
    @users.where.not(role: :admin).each do |user|
      user.time_clocks.each do |time|
        if time.clock_out.nil?
      else
        time.hours = time_diff(time.clock_in, time.clock_out)
        time.save!
      end
      end
    end
  end
end
