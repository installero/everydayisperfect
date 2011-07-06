class EventsController < ApplicationController
  before_filter :authenticate_user!

  def new
    @event = Event.new :routine => 'off'
  end

  def index
    if params[:week]
      @year, @week = params[:week].split("_").map(&:to_i)
      @fdate = Date.commercial(@year, @week, 1)
      @edate = @fdate.end_of_week
      @days_events = (1..7).to_a.map{|day| current_user.events.of_date(Date.commercial(@year, @week, day))}
    elsif params[:day]
      year,month,day = params[:day].split("_")
      @fdate = Date.parse("#{day}.#{month}.#{year}")
      @days_events = current_user.events.of_date(Date.parse("#{day}.#{month}.#{year}"))
    else
      if params[:month]
        @year, @month = params[:month].split("_")
      else
        @year = Date.today.year
        @month = Date.today.month
      end
      @fdate = Date.parse("1.#{@month}.#{@year}")
      @edate = @fdate.end_of_month
      last_day = @fdate.end_of_month.day
      @days_events = (1..last_day).to_a.map{|day| current_user.events.of_date(Date.parse("#{day}.#{@month}.#{@year}"))}
    end
  end

  def create
    @event = current_user.events.new(params[:event])

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
