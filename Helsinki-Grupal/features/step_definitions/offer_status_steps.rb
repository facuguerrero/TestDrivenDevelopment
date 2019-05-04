Given(/^I am logged in$/) do
  visit '/login'
  fill_in('user[email]', :with => 'offerer@test.com')
  fill_in('user[password]', :with => 'Passw0rd!')
  click_button('Login')
end

Given(/^I own an offer with title "(.*)"$/) do |title|
  @job_offer = JobOffer.new
  @job_offer.owner = User.first
  @job_offer.title = title
  @job_offer.location = 'a location'
  @job_offer.description = 'a nice job'
  @job_offer.save
  @id = @job_offer.id
end

Given(/^I access My Offers page$/) do
  visit '/job_offers/my'
end

Given(/^I am in the complete form page$/) do
  visit '/job_offers/my'
  click_link('Complete')
end

Given(/^I choose "Hired In" option$/) do
  choose('status_in')
end

Given(/^I choose "Hired Out" option$/) do
  choose('status_out')
end

Given(/^I choose "Closed" option$/) do
  choose('status_closed')
end

Given(/^The offer has expired$/) do
  @job_offer = JobOffer.get(@id)
  @job_offer.creation_date(DateTime.now() - 40) # More than a month away
  @job_offer.save
  JobOffer.expire_all
end

When(/^I click the Complete button$/) do
  click_button('Complete')
end

When(/^I click Complete in "(.*)"$/) do |offer_name|
  click_link('Complete')
end

Given(/^The offer's status is "Active"$/) do
  @job_offer = JobOffer.get(@id)
  @job_offer.status = 0
  @job_offer.save
end

Given(/^The offer's status is "Hired In"$/) do
  @job_offer = JobOffer.get(@id)
  @job_offer.status = 2
  @job_offer.save
  end

Given(/^The offer's status is "Hired Out"$/) do
  @job_offer = JobOffer.get(@id)
  @job_offer.status = 3
  @job_offer.save
end

Given(/^The offer's status is "Closed"$/) do
  @job_offer = JobOffer.get(@id)
  @job_offer.status = 4
  @job_offer.save
end

Given(/^The offer's status is "Expired"$/) do
  @job_offer = JobOffer.get(@id)
  @job_offer.status = 1
  @job_offer.save
end

Then(/^I should be in the complete form page$/) do
  page.should have_content('Complete')
end

Then(/^I should be in MyOffers page$/) do
  page.should have_content('My Job Offers')
end

Then(/^I should see "(.*)" in "A Test Job Offer" status field$/) do |status|
  page.should have_content(status)
end

After do |scenario|
  JobOffer.all.destroy
end