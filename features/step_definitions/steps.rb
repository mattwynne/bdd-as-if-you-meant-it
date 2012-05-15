AMOUNT = Transform /\$(\d+)/ do |raw_amount|
  raw_amount.to_i
end

Given /^I have (#{AMOUNT}) in my account$/ do |amount|
  create_account(amount)
end

When /^I withdraw (#{AMOUNT})$/ do |amount|
  withdraw(amount)
end

Then /^(#{AMOUNT}) should be dispensed$/ do |amount|
  cash_dispenser.last_amount_dispensed.should == amount
end

Then /^the balance of my account should be (#{AMOUNT})$/ do |amount|
  my_account.balance.should == amount
end
