Given /^I have \$(\d+) in my account$/ do |amount|
  create_account(amount)
end

When /^I withdraw \$(\d+)$/ do |amount|
  withdraw(amount)
end

Then /^\$(\d+) should be dispensed$/ do |amount|
  cash_dispenser.contents.should == amount
end

Then /^the balance of my account should be \$(\d+)$/ do |amount|
  my_account.balance.should == amount
end

class CashDispenser
  def contents
    "50"
  end
end

class Account
  def balance
    "450"
  end
end

module DomainDriver
  def create_account(balance)
  end

  def withdraw(amount)
  end

  def cash_dispenser
    CashDispenser.new
  end

  def my_account
    Account.new
  end
end

World(DomainDriver)
