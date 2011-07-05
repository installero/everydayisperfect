require 'machinist'
require 'machinist/active_record'
require 'sham' unless defined?(Sham)
require 'faker' unless defined?(Faker)

Sham.description(:unique => true) { Faker::Name.name }
Sham.start { Time.now + (13 + rand(48)).hour}

Event.blueprint do
  description
  start
  routine {'off'}
end
