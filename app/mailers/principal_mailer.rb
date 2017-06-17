class PrincipalMailer < ApplicationMailer
	default from: "zavier@tekzen.net"

  	def email(principal)
    	@principal = principal
    	@users = User.all.where(role: :admin)
    	mail(to: "xavier2miller@gmail.com", subject: 'Principal Form Filled Out')
  	end
end
