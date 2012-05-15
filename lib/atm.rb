class Money

  def initialize(amount)
    @amount = amount
  end

  def -(other_money)
    Money.new(@amount - other_money.amount)
  end

  def ==(other_money)
    @amount == other_money.amount
  end

  protected

  attr_reader :amount
end

class Account
  attr_reader :balance

  def initialize(balance)
    @balance = balance
  end

  def debit(amount)
    @balance = @balance - amount
  end
end

class Otto
  def initialize(cash_dispenser)
    @cash_dispenser = cash_dispenser
  end

  def authenticate_as(account)
    @account = account
  end

  def withdraw(amount)
    @account || raise("You need to call authenticate_as first!")
    @account.debit(amount)
    @cash_dispenser.dispense(amount)
  end
end

