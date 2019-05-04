Then(/^I should see "(.*?)" in the salary field of "(.*?)" offer$/) do |value, field|
  visit '/job_offers/my'
  page.should have_content(value)
end

After do |scenario|
  JobOffer.all.destroy
end