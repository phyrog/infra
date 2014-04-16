Feature: Create a torrent
  In order to share files with other users
  As a user
  I want to upload a new torrent

  @javascript
  Scenario: Upload a multi-file torrent
    Given I visit the torrents view
    When I upload the file "example1.torrent"
    And I enter data into the fields: "name", "description" with "Foo bar", "Bar foo"
    And I click "Save"
    Then I should see: "Foo bar"
    And I should see: "Bar foo"

  @javascript
  Scenario: Upload a single-file torrent
    Given I visit the torrents view
    When I upload the file "example2.torrent"
    And I enter data into the fields: "name", "description" with "Foo bar", "Bar foo"
    And I click "Save"
    Then I should see: "Foo bar"
    And I should see: "Bar foo"

  @javascript
  Scenario: Don't fill in all fields when uploading a torrent
    Given I visit the torrents view
    When I upload the file "example2.torrent"
    And I enter data into the fields: "name", "description" with "Foo bar", ""
    And I click "Save"
    Then I should see a message: "can't be blank"

  @javascript
  Scenario: Update the description of a torrent
    Given a torrent exists
    When I visit the edit torrent view
    And I enter data into the fields: "name", "description" with "Foo bar", "Some bar"
    And I click "Save"
    Then I should see: "Foo bar"
    And I should see: "Some bar"

  @javascript
  Scenario: Update the description of a torrent with invalid data
    Given a torrent exists
    When I visit the edit torrent view
    And I enter data into the fields: "name", "description" with "Foo bar", ""
    And I click "Save"
    Then I should see a message: "can't be blank"

  @javascript
  Scenario: Delete a torrent
    Given a torrent exists
    When I visit the edit torrent view
    And I click the link "Destroy"
    Then I should be redirected to the torrents view
