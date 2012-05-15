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

