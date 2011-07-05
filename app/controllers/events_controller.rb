class EventsController < ApplicationController
  def new
    @event = Event.new :routine => 'off'
  end

  def index
    @days = 1..31
    @events = []
    @days.each do |day|
      @events[day] = Event.new :start => Time.now, :description => 'Test'
    end
  end

  def create
    @event = Event.new(params[:event])

    Rails.logger.info(@event.inspect)

    respond_to do |format|
      if @event.save
        format.html { redirect_to(events_path, :notice => t('notices.new_event_created')) }
      else
        format.html { render :action => "new" }
      end
    end
  end

end
