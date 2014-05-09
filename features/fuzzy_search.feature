Feature: Fuzzy search
  In order to find a torrent
  As a user
  I want to search for some words that are similar to what I am looking for

  Scenario: I want to search for a word appearing in the name
    Given there is a torrent with name: "Some awesome torrent" and description: "This description is really nice too!"
    When I visit the page
    And I enter into the search bar: "awesome"
    And I click the button "Search"
    Then I can see the torrent

  Scenario: I want to search for a word appearing in the description
    Given there is a torrent with name: "Some awesome torrent" and description: "This description is really nice too!"
    When I visit the page
    And I enter into the search bar: "nice"
    And I click the button "Search"
    Then I can see the torrent

  Scenario: I want to search for a word that is spelled incorrectly
    Given there is a torrent with name: "Some awesome torrent" and description: "This description is really nice too!"
    When I visit the page
    And I enter into the search bar: "discrebton"
    And I click the button "Search"
    And I click the link "Some awesome torrent"
    Then I can see the torrent

  Scenario: I want to search for a word that matches no torrent
    Given there is a torrent with name: "Some awesome torrent" and description: "This description is really nice too!"
    When I visit the page
    And I enter into the search bar: "fabulous"
    And I click the button "Search"
    Then I can't see the torrent
