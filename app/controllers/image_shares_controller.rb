class ImageSharesController < ApplicationController
  def new
  	if current_user
  		redirect_to root_path
  	end
  	@image_share = ImageShare.new
  end

  def create
  	@image_share = ImageShare.new(image_share_params)
  end

  def show
  	@image = ImageShare.find(params[:id])
    send_data(@image.image_content,
            type: @image.image_type,
            filename: @image.image_name)
  end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_image_share
      @image_share = ImageShare.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def image_share_params
      params.require(:image_share).permit(:image_name, :image_content, :image_type, :image, :codename)
    end
end