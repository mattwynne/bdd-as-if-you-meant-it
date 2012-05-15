require_relative '../../lib/otto'

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

World(DomainDriver)
