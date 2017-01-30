class MoneyConverts

  attr_accessor :amount, :currency

  def initialize(amount, currency)
    @amount = amount
    @currency = currency
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

end
