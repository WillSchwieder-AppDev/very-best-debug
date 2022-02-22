class VenuesController < ApplicationController

  def index
    matching_venues = Venue.all
    @venues = matching_venues.order(:created_at)

    render({ :template => "venue_templates/venue_list.html.erb" })
  end

  def show
    venue_id = params.fetch("venue_id")
    matching_venues = Venue.where({ :id => venue_id })
    @the_venue = matching_venues.at(0)

    render({ :template => "venue_templates/details.html.erb" })
  end

  def create
    @venue = Venue.new
    venue.address = params.fetch("query_address")
    venue.name = params.fetch("name")
    venue.neighborhood = params.fetch("neighborhood")
    venue.save

    redirect_to("/venues/#{venue.name}")
  end
  
  def update
    the_id = params.fetch("the_id")
    the_address = params.fetch("query_address")
    the_name = params.fetch("query_name")
    the_neighborhood = params.fetch("query_neighborhood")

    venues = Venue.where({ :id => the_id })
    the_venue = venues.at(0)
    the_venue.address = the_address
    the_venue.name = the_name
    the_venue.neighborhood = the_neighborhood
    the_venue.save
    
    redirect_to("/venues/" + the_venue.id.to_s)
  end

  def destroy
    the_id = params.fetch("venue_id")
    matching_venues = Venue.where({ :id => the_id })
    venue = matching_venues.at(0)
    venue.destroy

    redirect_to("/venues")
  end

end
