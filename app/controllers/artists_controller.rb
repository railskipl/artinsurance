class ArtistsController < ApplicationController
  # GET /artists
  # GET /artists.json
  def index
    @artists = Artist.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @artists }
    end
  end   

  # GET /artists/1
  # GET /artists/1.json
  def show
    @artist = Artist.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @artist }
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

  # POST /artists
  # POST /artists.json
  def test

  end

  def create
    @artist = Artist.new()

     @grades = { "Name of Applicant" => params[:Name_of_Applicant],
           "Mailing Address" => params[:Mailing_Address],
           "Studio Address" => params[:current_year],
           "City" => params[:City],
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
           "Name of current insurance carrier" => params[:Name_of_current_insurance_carrier],
           
         }
    respond_to do |format|
      if @artist.save
        format.html { redirect_to new_subscription_path, notice: 'Artist was successfully created.' }
        format.json { render json: @artist, status: :created, location: @artist }
        ArtMail.art_mail(@grades).deliver

      else
        format.html { render action: "new" }
        format.json { render json: @artist.errors, status: :unprocessable_entity }
      end
    end
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
