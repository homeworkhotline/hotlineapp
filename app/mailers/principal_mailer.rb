class PrincipalMailer < ApplicationMailer
	default from: "homeworkhotlinenashville@gmail.com"

  	def email(principal)
    	@principal = principal
    	mail(to: "adrianne@homeworkhotline.info", subject: 'Principal Form Filled Out')
  	end
end
