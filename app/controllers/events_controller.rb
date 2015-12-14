class EventsController < ApplicationController
  def index
    @events = Event.all
  end

  def join
    Participant.create(user: User.find(current_user.id), event: Event.find(params[:id]))
    redirect_to('/events')
  end

  def delete
    Event.find(params[:id]).delete
    redirect_to('/events')
  end

  def cancel
    Participant.find_by(user: User.find(current_user.id), event: Event.find(params[:id])).delete
    redirect_to ('/events');
  end

  def show
    @event = Event.find(params[:id])
  end

  def edit
  end

  def add
    event = Event.new(name:params[:name], date:params[:date], location:params[:location], state:params[:state],user:User.find(current_user.id))
    if event.valid?
      event.save
      redirect_to '/events'
    else
      flash[:event_errors] = event.errors.full_messages
      redirect_to '/events'
    end
  end

  def comment
    Event.find(params[:id]).comments.create(content:params[:comment], user:User.find(current_user.id))
    redirect_to "/events/#{params[:id]}"
  end
  private 
  # Never trust parameters from the scary internet, only allow the white list through.
  # def event_params
  #   params.require(:event).permit(:name, :date, :location, :state, :user)
  # end
end
