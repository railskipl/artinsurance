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
    session[:id] = srand
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

        if params[:exhibits_year] == '0'
            params[:exhibits_year] = '5 or less'
        elsif params[:exhibits_year]  == '25'
            params[:exhibits_year] = '6 - $25'
        elsif params[:exhibits_year] ==  '50'
            params[:exhibits_year] = '7 - $50'
        elsif params[:exhibits_year] == '75'
            params[:exhibits_year] = '8 - $75'
        elsif params[:exhibits_year] == '100'
            params[:exhibits_year] = '9 - $100'
        elsif params[:exhibits_year] == '125'
            params[:exhibits_year] = '10 - $125'
        elsif params[:exhibits_year] == '150'
            params[:exhibits_year] = '11 - $150'
        elsif params[:exhibits_year] == '175'
            params[:exhibits_year] = '12 - $175'
        elsif params[:exhibits_year] == '200'
            params[:exhibits_year] = '13 - $200'
        elsif params[:exhibits_year] == '225'
            params[:exhibits_year] = '14 - $225'
        else params[:exhibits_year] == '250'
            params[:exhibits_year] = '15 - $250'
        end
        
        if params[:higher_limits] == '1000'
           params[:higher_limits] = '$100,000 - (Premium:$1,000)'
        elsif params[:higher_limits] == '1062'
           params[:higher_limits] = '$125,000 - (Premium:$1,062)'
        elsif params[:higher_limits] == '1203'
           params[:higher_limits] =  '$150,000 - (Premium:$1,203)'
        elsif params[:higher_limits] == '1344'
          params[:higher_limits] =  '$175,000 - (Premium:$1,344)'
        elsif params[:higher_limits] == '1484'
          params[:higher_limits] =  '$200,000 - (Premium:$1,484)'
        elsif params[:higher_limits] == '1625'
          params[:higher_limits] =  '$225,000 - (Premium:$1,625)'
        elsif params[:higher_limits] == '1765'
          params[:higher_limits] =  '$250,000 - (Premium:$1,765)'
        elsif params[:higher_limits] == '1907'
          params[:higher_limits] =  '$275,000 - (Premium:$1,907)'
        else params[:higher_limits] == '2047'
          params[:higher_limits] =  '$300,000 - (Premium:$2,047)'   
        end
      
        @grades = { 
             "start_date" => params[:start_date],
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
             "Date" => params[:start_date1] ,
             "Description Of Loss1" => params[:"Description Of Loss1"],
             "Amount Of Loss1" => params[:"Amount Of Loss1"],
             "Date1" => params[:start_date2] ,
             "Description Of Loss2" => params[:"Description Of Loss2"],
             "Amount Of Loss2" => params[:"Amount Of Loss2"],
             "Date2" => params[:start_date3] ,
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
        if params[:start_date] < Date.today.to_s
          format.html { redirect_to :back, notice: 'Please enter valid Proposed Effective date.' } 
        else
          if params[:"Studio & storage of art are in a basement"] == "Yes" && params[:"Is there a history of a back-up drain and/or sewer?"] == "Yes" && (@grades["Description Of Loss"] != nil && @grades["Description Of Loss1"] != nil && @grades["Description Of Loss2"] != nil)
          
          ArtMail.checkmail_all(session[:grades]).deliver
          format.html { redirect_to root_path, notice: 'Application is submitted to company for approval, will contact you via email, to follow up call 800 921-1008' } 
          
          elsif  (@grades["Description Of Loss"].present? && @grades["Description Of Loss1"].present? && @grades["Description Of Loss2"].present?) 
          
          ArtMail.checkmail(session[:grades]).deliver
          format.html { redirect_to root_path, notice: 'Application is submitted to company for approval, will contact you via email, to follow up call 800 921-1008' } 
          
          elsif params[:"Studio & storage of art are in a basement"] == "Yes" && params[:"Is there a history of a back-up drain and/or sewer?"] == "Yes"
          
          ArtMail.check_mail(session[:grades]).deliver
          format.html { redirect_to root_path, notice: 'Application is submitted to company for approval, will contact you via email, to follow up call 800 921-1008' } 
          
          elsif
            @artist.save
            format.html { redirect_to new_subscription_path(:order=> params[:session].to_i), notice: 'Artist application was successfully created.' }
            
            format.json { render json: @artist, status: :created, location: @artist }
               

            #ArtMail.art_mail(@grades).deliver
            
          else
            format.html { render action: "new" }
            format.json { render json: @artist.errors, status: :unprocessable_entity }
          end
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


