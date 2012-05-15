require_relative '../../lib/otto'

require 'capybara/cucumber'
Capybara.app = Sinatra::Application
Sinatra::Application.set :environment, :test

class FakeCashDispenser
  def dispense(amount)
    @last_amount_dispensed = amount
  end

  def last_amount_dispensed
    @last_amount_dispensed || raise("I am empty!")
  end
end

module DomainDriver
  def create_account(balance)
    @my_account = Account.new(balance)
  end

  def withdraw(amount)
    otto.authenticate_as(my_account)
    otto.withdraw(amount)
  end

  def cash_dispenser
    @cash_dispenser ||= FakeCashDispenser.new
  end

  def my_account
    @my_account || raise("Please call #create_account first!")
  end

  private

  def otto
    @otto ||= Otto.new(cash_dispenser)
  end
end

module UserInterfaceDriver
  def create_account(balance)
    @my_account = Account.new(balance)
  end

  def withdraw(money)
    Sinatra::Application.set :account, my_account
    Sinatra::Application.set :cash_dispenser, cash_dispenser
    visit '/'
    fill_in 'Amount', :with => money.amount
    click_button 'Withdraw'
  end

  def cash_dispenser
    @cash_dispenser ||= FakeCashDispenser.new
  end

  def my_account
    @my_account || raise("Please call #create_account first!")
  end
end

World(UserInterfaceDriver)

After do |scenario|
  save_and_open_page if scenario.failed?
end
