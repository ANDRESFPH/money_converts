class MoneyConverts

  attr_accessor :amount, :currency

  def initialize(amount, currency)
    @amount = amount
    @currency = currency
  end

  def self.conversion_rates(base_currency, rates)

  end

  def convert_to(to_currency)
  end

end
