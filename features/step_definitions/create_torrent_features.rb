Given(/^I visit the torrents view$/) do
  visit torrents_path
end

Given(/^a torrent exists$/) do
  visit torrents_path
  attach_file 'torrent_file', "features/support/example1.torrent"
  fill_in "torrent_name", with: "Foo bar"
  fill_in "torrent_description", with: "Bar foo"
  click_button "Save"
end

When(/^I visit the edit torrent view$/) do
  click_link "Edit"
end

When(/^I upload the file "(.+)"$/) do |file|
  attach_file 'torrent_file', "features/support/#{file}"
end

When(/^I enter data into the fields: "(.*)", "(.*)" with "(.*)", "(.*)"$/) do |field1, field2, content1, content2|
  fill_in "torrent_#{field1}", with: content1
  fill_in "torrent_#{field2}", with: content2
end

When(/^I click "(.*?)"$/) do |name|
  click_button name
end

When(/^I click the link "(.*?)"$/) do |name|
  click_link name
end

Then(/^I should see: "(.*)"$/) do |msg|
  expect(page).to have_content(msg)
end

Then(/^I should see a message: "(.*)"$/) do |message|
  expect(page).to have_content(message)
end

Then(/^I should be redirected to the torrents view$/) do
  expect(current_path).to eq(torrents_path)
end
