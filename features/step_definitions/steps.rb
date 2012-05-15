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
  attr_reader :balance

  def initialize(balance)
    @balance = balance
  end

  def debit(amount)
    @balance -= amount
  end
end

class Teller
  def initialize(cash_dispenser)
    @cash_dispenser = cash_dispenser
  end

  def authenticate_as(account)
    @account = account
  end

  def withdraw(amount)
    @account.debit(amount)
    @cash_dispenser.dispense(amount)
  end
end

module DomainDriver
  def create_account(balance)
    @my_account = Account.new(balance)
  end

  def withdraw(amount)
    teller.authenticate_as(my_account)
    teller.withdraw(amount)
  end

  def cash_dispenser
    @cash_dispenser ||= CashDispenser.new
  end

  def my_account
    @my_account || raise("Please call #create_account first!")
  end

  private

  def teller
    @teller ||= Teller.new(cash_dispenser)
  end
end

World(DomainDriver)
