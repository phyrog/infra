Given(/^there is a torrent with name: "(.*?)" and description: "(.*?)"$/) do |name, description|
  @torrent = Torrent.create(name: name, description: description, file: "")
end

When(/^I visit the page$/) do
  visit root_path
end

When(/^I enter into the search bar: "(.*?)"$/) do |term|
  fill_in "q", with: term
end

When(/^I click the button "(.*?)"$/) do |button|
  click_button button
end

Then(/^I (can|can't) see the torrent$/) do |can_see|
  if can_see == "can"
    expect(page).to have_content(@torrent.name)
  else
    expect(page).not_to have_content(@torrent.name)
  end
end
