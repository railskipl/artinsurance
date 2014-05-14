class ArtMail < ActionMailer::Base
  default from: "rubyrails9@gmail.com"




def art_mail(grades)
	
	@grades = grades
	email1 = "andrewxodo@gmail.com"
    email2 = "andrew@madloch.com"
    email3 = "andrew@veraxon.com"
    email4 = "ankit@kunalinfotech.net" 
    email5 = "andrew@yougame.com"
    
    recipients = email1, email2, email3, email4, email5
    subject = "Insurence"
   
        mail(:subject => 'Insurance', :to => recipients.join(','))  do |format|
        format.html
        format.pdf do
        attachments["attachement_name.pdf"] = WickedPdf.new.pdf_from_string(
        render_to_string(:pdf => "receipt", :template => 'art_mail/art_mail.pdf.erb')
        )
    end
   end
end


# def request_by_mail(car, your_name, your_message)
#     @car = car
#     @name = your_name
#     @message = your_message
#     @url  = "http://cardealer.com/cars"
#   #  attachments["rails.png"] = File.read("#{Rails.root}/public/images/rails.png")
#     mail(:to => 'rmagnum2002@gmail.com',
#          :subject => "Car details request from a client",
#          :date => Time.now
#          )
#   end

end
