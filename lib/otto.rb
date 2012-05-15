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

require 'sinatra'

get '/' do
%{
  <html>
    <body>
      <p>
        Moi, olen Otto
      </p>
      <form action="/withdraw" method="POST">
        <label for="amount">Amount</label><br/>
        <input type="text" name="amount" id="amount"/><br/>
        <input type="submit" value="Withdraw"/>
      </form>
    </body>
  </html>
}
end

post '/withdraw' do
  otto = Otto.new(settings.cash_dispenser)
  otto.authenticate_as(settings.account)
  otto.withdraw(Money.new(params[:amount].to_i))
end
