Given(/^I access my offers page$/) do
  visit '/job_offers/latest'
end

Given(/^Nobody applied to my offer$/) do
end

When(/^I apply with "(.*?)"$/) do |mail|
  click_link('Apply')
  fill_in('job_application[applicant_email]', :with => mail)
  click_button('Apply')
end

Then(/^I should see "(.*?)" in the applicants field of the offer$/) do |applicants|
  visit '/job_offers/my'
  page.should have_content(applicants)
end

After do |scenario|
  JobOffer.all.destroy
end