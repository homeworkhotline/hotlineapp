class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
   def destroy
    @time_clock = current_user.time_clocks.last
    if current_user.mnps_teacher?
      @time_clock.clock_out = round_time(Time.now - 5.hours).strftime("%k:%M:%S")
      @time_clock.clock_out = @time_clock.clock_out
      @time_clock.save!
    else
      @time_clock.clock_out = (Time.now - 5.hours).strftime("%k:%M:%S")
      @time_clock.clock_out = @time_clock.clock_out
      @time_clock.save!
    end
    @time_clock.billed = 0
    @time_clock.save!
    super
   end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
