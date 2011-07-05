require 'spec_helper'

describe Event do
  should_have_many :repetitions, :dependent => :destroy
  should_accept_nested_attributes_for :repetitions
end
