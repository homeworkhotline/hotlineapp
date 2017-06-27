class PrincipalMailer < ApplicationMailer
	default from: "volunteer@homeworkhotline.info"

  	def email(principal)
    	@principal = principal
    	mail(to: "volunteer@homeworkhotline.info", subject: 'Principal Form Filled Out')
  	end
end
