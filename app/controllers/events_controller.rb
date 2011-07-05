class EventsController < ApplicationController
  def new
    @event = Event.new :routine => 'off'
  end

  def index
    params[:month]
    @days = 1..31
    year = Time.now.year
    month = Time.now.month
    @max_days = 31
    @days_events = (1..@max_days).to_a.map{|day| Event.where(['start > ? AND routine = "off" AND start < ?', Time.parse("#{day}.#{month}.#{year}").beginning_of_day, Time.parse("#{day}.#{month}.#{year}").end_of_day]).all + Event.joins(:repetitions).where(['start < ? AND routine = "mount"', Time.parse("#{day}.#{month}.#{year}")]).where(:repetitions => {:day => day}).all}
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
