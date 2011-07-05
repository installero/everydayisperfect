require 'spec_helper'

describe "events/new.html.erb" do
  before(:each) do
    assign(:event, stub_model(Event).as_new_record)
  end

  it "should render event fields" do
    render
    rendered.should have_selector("form", :action => events_path, :method => "post") do |form|
      form.should have_selector("input", :type => "textarea", :name => "event[description]")
      form.should have_selector("input", :name => "event[start]")
      form.should have_selector("input", :name => "event[routine]")
    end
  end

  it "should render event routine control fields" do
    render
      rendered.should have_selector("input", :type => "checkbox", :name => "event_has_routine")
      #rendered.should have_selector("select", :name => "event[fare_classes_attributes][0][fare_class_type]")
      #rendered.should have_selector("input", :name => "event[fare_classes_attributes][0][fare_class_prices_attributes][0][price]")
      #rendered.should have_selector("input", :name => "event[fare_classes_attributes][0][fare_class_prices_attributes][1][price]")
      #rendered.should have_selector("input", :name => "event[fare_classes_attributes][0][fare_class_prices_attributes][2][price]")
      #rendered.should have_selector("input", :name => "event[fare_classes_attributes][0][fare_class_prices_attributes][3][price]")
      #rendered.should have_selector("input", :name => "event[fare_classes_attributes][0][chmop]")
    end
  end
end
