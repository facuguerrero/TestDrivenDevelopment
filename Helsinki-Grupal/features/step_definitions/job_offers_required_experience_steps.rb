When(/^I fill the "(.*?)" field with "(.*?)"$/) do |experience, time|
  fill_in('job_offer[' + experience + ']', :with => time)
end

Then(/^I should see "(.*?)" in the years experience field of "(.*?)" offer$/) do |years, job_title|
  visit '/job_offers/my'
  page.should have_content(years)
end

When(/^I don’t fill the "(.*?)" field$/) do |experience|
end

After do |scenario|
  JobOffer.all.destroy
end