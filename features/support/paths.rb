module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in web_steps.rb
  #
  def path_to(page_name)
    case page_name

    when /^the events page for the (\d+)(?:st|nd|rd|th) month of the (\d+)(?:st|nd|rd|th) year$/
      events_path(:month => "#{$2}_#{$1}")
    when /^the events page for the (\d+)(?:st|nd|rd|th) week of the (\d+)(?:st|nd|rd|th) year$/
      events_path(:week => "#{$2}_#{$1}")
    when /^the events page for the (\d+)(?:st|nd|rd|th) day of the (\d+)(?:st|nd|rd|th) month of the (\d+)(?:st|nd|rd|th) year$/
      events_path(:day => "#{$3}_#{$2}_#{$1}")

    # Add more mappings here.
    # Here is an example that pulls values out of the Regexp:
    #
    #   when /^(.*)'s profile page$/i
    #     user_profile_path(User.find_by_login($1))

    else
      begin
        page_name =~ /^the (.*) page$/
        path_components = $1.split(/\s+/)
        self.send(path_components.push('path').join('_').to_sym)
      rescue NoMethodError, ArgumentError
        raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
          "Now, go and add a mapping in #{__FILE__}"
      end
    end
  end
end

World(NavigationHelpers)
