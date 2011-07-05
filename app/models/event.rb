class Event < ActiveRecord::Base
  has_many :repetitions, :dependent => :destroy
  accepts_nested_attributes_for :repetitions
end
