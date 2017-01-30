class MoneyConverts

  include Comparable

  attr_accessor :amount, :currency

  def initialize(amount, currency)
    @amount = amount
    @currency = currency
  end

  def <=>(money)
    if currency == money.currency
      amount <=> money.amount
    else
      value = money.convert_to(currency)
      amount <=> value.amount
    end
  end

  def self.conversion_rates(base_currency, rates)
    @@base_currency = base_currency
    @@rates = rates
  end

  def convert_to(to_currency)
    if currency == @@base_currency
      value = amount * @@rates[to_currency]
      MoneyConverts.new(value, to_currency)
    elsif currency != @@base_currency && to_currency == @@base_currency
      value = amount / @@rates[currency]
      MoneyConverts.new(value, to_currency)
    else
      base_currency = self.convert_to(@@base_currency)
      base_currency.convert_to(to_currency)
    end
  end

  def *(value)
    if value.is_a?(Numeric)
      result = amount * value
      MoneyConverts.new(result, currency)
    else
      operate_on_currency(value, :*)
    end
  end


  private

  def operate_on_currency(value, operator)
    if value.currency == currency
      result = value.amount.send(operator, amount)
      MoneyConverts.new(result, currency)
    else
      result = value.convert_to(currency).amount.send(operator, amount)
      MoneyConverts.new(result, currency)
    end
  end

end
