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

class CashDispenser
  def dispense(amount)
    @last_amount_dispensed = amount
  end

  def last_amount_dispensed
    @last_amount_dispensed || raise("I am empty!")
  end
end

class Account
  def balance
  end
end

class Teller
  def initialize(cash_dispenser)
    @cash_dispenser = cash_dispenser
  end

  def authenticate_as(account)
  end

  def withdraw(amount)
    @cash_dispenser.dispense(amount)
  end
end

module DomainDriver
  def create_account(balance)
  end

  def withdraw(amount)
    teller.authenticate_as(my_account)
    teller.withdraw(amount)
  end

  def cash_dispenser
    @cash_dispenser ||= CashDispenser.new
  end

  def my_account
    Account.new
  end

  private

  def teller
    Teller.new(cash_dispenser)
  end
end

World(DomainDriver)
