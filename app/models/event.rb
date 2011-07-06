class Event < ActiveRecord::Base
  has_many :repetitions, :dependent => :destroy
  accepts_nested_attributes_for :repetitions
  belongs_to :user

  def self.of_date(date)
    where('routine = "off" AND start >= ? AND start <= ?', date.beginning_of_day, date.end_of_day) +
    joins(:repetitions).where('routine = "month"').where(:repetitions => {:day => date.day}) +
    joins(:repetitions).where('routine = "week"').where(:repetitions => {:day => date.wday-1})
  end
end
