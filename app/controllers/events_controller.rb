class EventsController < ApplicationController
  def new
    @event = Event.new :routine => 'off'
  end

  def index
    if params[:month]
      year = params[:month].split("_")[0]
      month = params[:month].split("_")[1]
      last_day = Date.parse("#{year}.#{month}.01").end_of_month.day
      @days_events = (1..last_day).to_a.map{|day| Event.where(['start > ? AND routine = "off" AND start < ?', Time.parse("#{day}.#{month}.#{year}").beginning_of_day, Time.parse("#{day}.#{month}.#{year}").end_of_day]).all + Event.joins(:repetitions).where(['start < ? AND routine = "mount"', Time.parse("#{day}.#{month}.#{year}")]).where(:repetitions => {:day => day}).all}
    elsif params[:week]
      year = params[:week].split("_")[0].to_i
      week = params[:week].split("_")[1].to_i
      @days_events = (1..7).to_a.map{|day| Event.where(['start > ? AND routine = "off" AND start < ?', Date.commercial(year, week, day).beginning_of_day, Date.commercial(year, week, day).end_of_day]).all}
    elsif params[:day]
      year = params[:day].split("_")[0]
      month = params[:day].split("_")[1]
      day = params[:day].split("_")[2]
      @days_events = Event.where(['start > ? AND routine = "off" AND start < ?', Date.parse("#{day}.#{month}.#{year}").beginning_of_day, Date.parse("#{day}.#{month}.#{year}").end_of_day]).all
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
