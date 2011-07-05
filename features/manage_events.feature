Feature: Manage events
  In order to manage events
  simple user
  wants to CRUD events
  
  @javascript
  Scenario: Adding new event without repetition
    Given I am on the new event page
        And I fill in "event[description]" with "Рождение"
        And I fill in "event[start]" with "14.09.1984, 14:55"
        And I press "Сохранить"
    Then a event should exist with description: "Рождение", start: "1984-09-14 14:55:00", routine: "off"

  @javascript
  Scenario: Adding new event with weekly repetition
    Given I am on the new event page
        And I fill in "event[description]" with "Свадьба"
        And I fill in "event[start]" with "05.07.2011, 10:05"
        And I check "event_has_routine"
        And I check "event_week_1"
        And I check "event_week_6"
        And I press "Сохранить"
    Then a event "Свадьба" should exist with description: "Свадьба", start: "2011-07-05 10:05:00", routine: "week"
        And a repetition should exist with day: "1", event: event "Свадьба"
        And a repetition should exist with day: "6", event: event "Свадьба"

  @javascript
  Scenario: Adding new event with monthly repetition
    Given I am on the new event page
        And I fill in "event[description]" with "Смерть"
        And I fill in "event[start]" with "20.01.2038, 17:55"
        And I check "event_has_routine"
        And I follow "select_month"
        And I fill in "event[repetitions_attributes][1][day]" with "20"
        And I follow "add_repetition"
        And I fill in "event[repetitions_attributes][2][day]" with "21"
        And I press "Сохранить"
    Then a event "Смерть" should exist with description: "Смерть", start: "2038-01-20 17:55:00", routine: "month"
        And a repetition should exist with day: "20", event: event "Смерть"
        And a repetition should exist with day: "20", event: event "Смерть"

  Scenario: Viewing events by month
    Given an event exists with description: "Рождение", start: "2011-07-05 14:55:00", routine: "off"
      And an event exists with description: "Второе рождение", start: "2011-07-25 15:20:00", routine: "off"
      And an event exists with description: "Третье рождение", start: "2011-07-25 18:40:00", routine: "off"
      And an event exists with description: "Первая смерть", start: "2011-09-15 08:20:00", routine: "off"
      And an event exists with description: "Вторая смерть", start: "2011-09-24 20:40:00", routine: "off"
      And an event exists with description: "Третья смерть", start: "2011-09-26 19:40:00", routine: "off"
      #And an event "Свадьба" exists with description: "Свадьба", start: "2011-07-06 10:05:00", routine: "week"
      #And a repetition exists with day: "1", event: event "Свадьба"
      #And a repetition exists with day: "6", event: event "Свадьба"
      #And an event "Смерть" exists with description: "Смерть", start: "2011-07-30 17:55:00", routine: "month"
      #And a repetition exists with day: "20", event: event "Смерть"
      #And a repetition exists with day: "20", event: event "Смерть"
    When I am on the events page for the 7th month of the 2011th year
    Then I should see "14:55 Рождение"
      And I should see "15:20 Второе рождение"
      And I should see "18:40 Третье рождение"
      And I should not see "08:20 Первая смерть"
    When I am on the events page for the 9th month of the 2011th year
    Then I should not see "14:55 Рождение"
      And I should see "08:20 Первая смерть"
      And I should see "20:40 Вторая смерть"
      And I should see "19:40 Третья смерть"

  Scenario: Viewing events by week
    Given an event exists with description: "Рождение", start: "2011-07-05 14:55:00", routine: "off"
      And an event exists with description: "Второе рождение", start: "2011-07-25 15:20:00", routine: "off"
      And an event exists with description: "Третье рождение", start: "2011-07-25 18:40:00", routine: "off"
      And an event exists with description: "Первая смерть", start: "2011-09-15 08:20:00", routine: "off"
      And an event exists with description: "Вторая смерть", start: "2011-09-24 20:40:00", routine: "off"
      And an event exists with description: "Третья смерть", start: "2011-09-26 19:40:00", routine: "off"
    When I am on the events page for the 30th week of the 2011th year
    Then I should not see "14:55 Рождение"
      And I should see "15:20 Второе рождение"

  Scenario: Viewing events by day
    Given an event exists with description: "Рождение", start: "2011-07-05 14:55:00", routine: "off"
      And an event exists with description: "Второе рождение", start: "2011-07-25 15:20:00", routine: "off"
      And an event exists with description: "Третье рождение", start: "2011-07-25 18:40:00", routine: "off"
      And an event exists with description: "Первая смерть", start: "2011-09-15 08:20:00", routine: "off"
      And an event exists with description: "Вторая смерть", start: "2011-09-24 20:40:00", routine: "off"
      And an event exists with description: "Третья смерть", start: "2011-09-26 19:40:00", routine: "off"
    When I am on the events page for the 24th day of the 9th month of the 2011th year
    Then I should not see "19:40 Третья смерть"
      And I should see "20:40 Вторая смерть"
