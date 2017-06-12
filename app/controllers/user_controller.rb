class UserController < ApplicationController
  before_action :authenticate_user!

  def show
  	@user = User.find(params[:id])
  	@total_hours = 0
    @unpaid_hours = 0
    @mnps_report = MnpsReport.new
  	@user.time_clocks.each do |time|
  		if time.hours.nil?
  		else
        @total_hours += time.hours.round
      end
    end
  @user.time_clocks.where(billed: false).each do |time|
    if time.hours.nil?
      @unpaid_hours += 0
    else
    @unpaid_hours += time.hours
  end
  end
  end
end
