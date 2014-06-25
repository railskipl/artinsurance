class ArtistsController < ApplicationController
   respond_to :html, :js, :json
  # GET /artists
  # GET /artists.json
  def index
    @artists = Artist.all

    redirect_to root_path
  end   

  # GET /artists/1
  # GET /artists/1.json
  def show
    @artist = Artist.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.pdf do
        render :pdf => "@artist"
      end
    end
  end


  

  # GET /artists/new
  # GET /artists/new.json
  def new
    @artist = Artist.new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @artist }
    end
  end


  

  # GET /artists/1/edit
  def edit
    @artist = Artist.find(params[:id])
  end


  def home
  end

  # POST /artists
  # POST /artists.json
  def create
    @artist = Artist.new()

         @limits_of_studio_insurance = params[:higher_limits]
         @exhibits_year = params[:exhibits_year]
         @anualpremium = ((@limits_of_studio_insurance).to_i + (@exhibits_year).to_i).to_i
         session[:anualpremium] = @anualpremium
      if params[:State] 
        params[:State] = params[:State] 
      else 
        params[:State] = params[:us_states]
      end
     
     @grades = { 
           "Date" => params[:start_date],
           "First Name" => params[:first_name],
           "last Name" => params[:last_name],
           "Address 1" => params[:Address1],
           "Address 2" => params[:Address2],
           "City" => params[:City],
           "state" => params[:State],
           "Zip" => params[:Zip],
           "Studio Address" => params[:Studio_Address],
           "Studio_Address2" => params[:Studio_Address2],
           "Studio City" => params[:Studio_City],
           "us_states" => params[:us_states],
           "Zip Code" => params[:Zip_Code],
           "Phone Number" => params[:Phone_Number],
           "Fax" => params[:Fax],
           "E-mail address" => params[:Email_address],
           "Retype E-Mail" => params[:Retype_EMail],
           "higher_limits" => params[:higher_limits],
           "limit_of_Insurance_at_Other_Location" => params[:limit_of_Insurance_at_Other_Location],
           "limit_of_Insurance_While_in_Transit" => params[:limit_of_Insurance_While_in_Transit],
           "Policy Deductable" => params[:Policy_Deductable],
           "finished_art_work" => params[:finished_art_work],
           "single_item" => params[:single_item],
           "When was the last date of inventory" => params[:When_was_the_last_date_of_inventory?],
           "exhibits_year" => params[:exhibits_year],
           "current_year" => params[:current_year],
           "prior_year" => params[:prior_year],
           "studio" => params[:studio],
           "card_signup_date" => params[:card_signup][:"dob(2i)"],
           "card_signup_year" => params[:card_signup][:"dob(1i)"],
           "Studio & storage of art are in a basement" => params[:"Studio & storage of art are in a basement"],
           "Name of current insurance carrier" => params[:Name_of_current_insurance_carrier],
           "Description Of Loss" => params[:"Description Of Loss"],
           "Amount Of Loss" => params[:"Amount Of Loss"],
           "Date" => "#{params[:card_lost][:"lost_date(1i)"]} - #{params[:card_lost][:"lost_date(2i)"]} - #{params[:card_lost][:"lost_date(3i)"]}" ,
           "Description Of Loss1" => params[:"DescriptionOfLoss_1"],
           "Amount Of Loss1" => params[:"AmountOfLoss_1"],
           "Date1" => "#{params[:card_lost][:"lost_date(11)"]} - #{params[:card_lost][:"lost_date(21)"]} - #{params[:card_lost][:"lost_date(31)"]}" ,
           "Description Of Loss2" => params[:"DescriptionOfLoss_2"],
           "Amount Of Loss2" => params[:"AmountOfLoss_2"],
           "Date2" => "#{params[:card_lost][:"lost_date(12)"]} - #{params[:card_lost][:"lost_date(22)"]} - #{params[:card_lost][:"lost_date(32)"]}" ,
           "paintings" => params[:paintings],
           "furniture" => params[:furniture],
           "drawings" => params[:drawings],
           "fabrics" => params[:fabrics],
           "photographs" => params[:photographs],
           "jewelry" => params[:jewelry],
           "sculptures" => params[:sculptures],
           "non_Fragile" => params[:non_Fragile],
           "breakable" => params[:breakable],
           "other" => params[:other],
           "pre1950" => params[:year_built],
           "Studio_&_storage_of_art_are_in_a_basement" => params[:"Studio & storage of art are in a basement"],
           "Is_there_history_of_back_up_drain" => params[:"Is there a history of a back-up drain and/or sewer?"],
           "stored_on_skits_or_shelf" => params[:"If yes works stored on skits or shelf?"],
           "automatic_sprinkler_system" => params[:"Is there an automatic sprinkler system on premises?"],
           "detailed_and_itemized" => params[:"Do you keep a detailed and itemized?"],
           "keep_record_of_sales" => params[:"Do you keep a record of sales?"],
           "duplicate_inventory_off_site" => params[:"Do you maintain a duplicate inventory off-site?"],
           "deadbolts" => params[:deadbolts],
           "alarm" => params[:alarm],
           "local_alaram" => params[:local_alaram],
           "cameras" => params[:cameras],
           "gates" => params[:gates],
           "watchmen" => params[:watchmen],
           "no_security" => params[:no_security],
           "lost_date" => "#{params[:card_signup][:"lost_date(3i)"]} - #{params[:card_signup][:"lost_date(2i)"]} - #{params[:card_signup][:"lost_date(1i)"]}",
           "annual_premium" => @anualpremium
           
         }
         @email = params[:Email_address]
         session[:email] = @email
         session[:grades] = @grades 
      respond_to do |format|

        
        if params[:"Studio & storage of art are in a basement"] == "Yes" && params[:"Is there a history of a back-up drain and/or sewer?"] == "Yes" && (@grades["Description Of Loss"] != nil && @grades["Description Of Loss1"] != nil && @grades["Description Of Loss2"] != nil)
        
        ArtMail.checkmail_all(session[:grades]).deliver
        format.html { redirect_to root_path, notice: 'Application is submitted to company for approval, will contact you via email, to follow up call 800 921-1008' } 
        
        elsif  (@grades["Description Of Loss"] != nil && @grades["Description Of Loss1"] != nil && @grades["Description Of Loss2"] != nil) 
        
        ArtMail.checkmail(session[:grades]).deliver
        format.html { redirect_to root_path, notice: 'Application is submitted to company for approval, will contact you via email, to follow up call 800 921-1008' } 
        
        elsif params[:"Studio & storage of art are in a basement"] == "Yes" && params[:"Is there a history of a back-up drain and/or sewer?"] == "Yes"
        
        ArtMail.check_mail(session[:grades]).deliver
        format.html { redirect_to root_path, notice: 'Application is submitted to company for approval, will contact you via email, to follow up call 800 921-1008' } 
        
        elsif
          @artist.save
          format.html { redirect_to new_subscription_path, notice: 'Artist was successfully created.' }
          
          format.json { render json: @artist, status: :created, location: @artist }
             

          #ArtMail.art_mail(@grades).deliver
          
        else
          format.html { render action: "new" }
          format.json { render json: @artist.errors, status: :unprocessable_entity }
        end
      end
    
  end



  def artist_preview
    @grades = params
  end

  # PUT /artists/1
  # PUT /artists/1.json
  def update
    @artist = Artist.find(params[:id])

    respond_to do |format|
      if @artist.update_attributes(params[:artist])
        format.html { redirect_to @artist, notice: 'Artist was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @artist.errors, status: :unprocessable_entity }
      end
    end
  end

  
def preview
  @artist = Artist.find(params[:id])
  raise @artist.inspect
end

  # DELETE /artists/1
  # DELETE /artists/1.json
  def destroy
    @artist = Artist.find(params[:id])
    @artist.destroy

    respond_to do |format|
      format.html { redirect_to artists_url }
      format.json { head :no_content }
    end
  end
end


