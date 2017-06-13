class StudentsController < ApplicationController
	def edit
	end

	def update
		@student = Student.find(params[:id])
    respond_to do |format|
      if @student.update(student_params)
        format.html { redirect_to :back, notice: 'Student was successfully updated.' }
        format.json { render :show, status: :ok, location: @student }
      else
        format.html { render :edit }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end
	  private
    # Use callbacks to share common setup or constraints between actions.
    def set_student
      @student = Student.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def student_params
      params.require(:student).permit(:grade, :codename, :internet, :homelang, :school_id)
    end
end