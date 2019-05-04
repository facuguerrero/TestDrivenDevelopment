Given(/^a "(.*)" offer exists in the offers list located in (.*) with description "(.*)"$/) do |title, location, description|
  @job_offer = JobOffer.new
  @job_offer.owner = User.first
  @job_offer.title = title
  @job_offer.location = location
  @job_offer.description = description
  @job_offer.save
end

Given(/^I access the job offer page$/) do
  visit '/job_offers/latest'
end

Given(/^I input "(.*)" in the search box$/) do |input|
  fill_in('q', :with => input)
end

When(/^I click search$/) do
  click_button('search')
end

Then(/^I should see "(.*)" in Job Offers$/) do |content|
  page.should have_content(content)
end

After do |scenario|
  JobOffer.all.destroy
end
