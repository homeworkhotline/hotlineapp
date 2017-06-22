class PrincipalMailer < ApplicationMailer
	default from: "homeworkhotlinenashville@gmail.com"

  	def email(principal)
    	@principal = principal
    	mail(to: "xavier2miller@gmail.com", subject: 'Principal Form Filled Out')
  	end
end
