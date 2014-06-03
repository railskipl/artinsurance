class ArtMail < ActionMailer::Base
  default from: "rubyrails9@gmail.com"




def art_mail(grades)
	
	@grades = grades
	   # email1 = "andrewxodo@gmail.com"
	   # email2 = "andrew@madloch.com"
	   # email3 = "andrew@veraxon.com"
	   # email4 = "andrew@yougame.com"

       email1 = "amol@kunalinfotech.net"
       email2 = "anup@kunalinfotech.net"
       email3 = "sagar.kale@kunalinfotech.net"
       
   
    recipients = email1, email2, email3
    subject = "Insurence"
   
        mail(:subject => 'Insurance', :to => recipients.join(','))  do |format|
        format.html
        format.pdf do
        attachments["Bernard_Fleischer_&_Sons_Inc.pdf"] = WickedPdf.new.pdf_from_string(
        render_to_string(:pdf => "receipt", :template => 'art_mail/art_mail.pdf.erb')
        )
    end
   end
end


def feedback_mail(feedbk)

    @feedbk = feedbk
    mail(:to => "amol@kunalinfotech.net", :subject => "Feedback")
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


