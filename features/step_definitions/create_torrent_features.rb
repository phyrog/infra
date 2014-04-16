Given(/^I visit the torrents view$/) do
  visit torrents_path
end

When(/^I upload a torrent file$/) do
  attach_file 'torrent_file', 'features/support/example.torrent'
  save_and_open_page
end

When(/^I enter data into the fields: "(.*?)", "(.*?)"$/) do |field1, field2|
  fill_in 'torrent_name', with: 'Foo bar'
  fill_in 'torrent_description', with: 'Bar foo'
  pending # express the regexp above with the code you wish you had
end

When(/^I click "(.*?)"$/) do |name|
  click_button name
end

Then(/^I should see the data of the created torrent$/) do
  pending # express the regexp above with the code you wish you had
end
