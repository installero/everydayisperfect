Given /^the following events:$/ do |events|
  Events.create!(events.hashes)
end

When /^I delete the (\d+)(?:st|nd|rd|th) events$/ do |pos|
  visit events_path
  within("table tr:nth-child(#{pos.to_i+1})") do
    click_link "Destroy"
  end
end

Then /^I should see the following events:$/ do |expected_events_table|
  expected_events_table.diff!(tableish('table tr', 'td,th'))
end

When /^I am signed in$/ do
  email = 'install.vv@gmail.com'
  password = '12345678'
  Given %{a user "Пользователь" exists with email: "#{email}", password: "#{password}"}
  And %{I am on the new user session page}
  And %{I fill in "user_email" with "#{email}"}
  And %{I fill in "user_password" with "#{password}"}
  And %{I press "submit"}
end
