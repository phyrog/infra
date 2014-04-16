Feature: Create a torrent
  In order to share files with other users
  As a user
  I want to upload a new torrent

  @javascript
  Scenario: Upload a new torrent file
    Given I visit the torrents view
    When I upload a torrent file
    And I enter data into the fields: "name", "description"
    And I click "Save"
    Then I should see the data of the created torrent

