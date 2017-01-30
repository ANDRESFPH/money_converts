require_relative 'spec_helper'

describe MoneyConverts do
  describe '.convert_to' do
    it 'converts from a currency to another' do
      MoneyConverts.conversion_rates('EUR', {
        'USD'     => 1.11,
        'Bitcoin' => 0.0047
      })

      fifty_euros = MoneyConverts.new(50, 'EUR')
      twenty_dollars = MoneyConverts.new(20, 'USD')

      eur_to_dollar = 50 * 1.11
      dollar_to_eur = 20 / 1.11
      dollar_to_bitcoin = 20 / 1.11 * 0.0047

      expect(fifty_euros.convert_to('USD').amount).to eq eur_to_dollar
      expect(twenty_dollars.convert_to('EUR').amount).to eq dollar_to_eur
      expect(twenty_dollars.convert_to('Bitcoin').amount).to eq dollar_to_bitcoin
    end
  end

  describe 'comparisons' do
    it 'makes comparisons between currencies' do
      MoneyConverts.conversion_rates('EUR', {
        'USD'     => 1.11,
        'Bitcoin' => 0.0047
      })

      fifty_euros = MoneyConverts.new(50, 'EUR')
      fifty_eur = MoneyConverts.new(50, 'EUR')
      twenty_dollars = MoneyConverts.new(20, 'USD')
      ten_eur = MoneyConverts.new(10, 'EUR')

      expect(fifty_euros == fifty_eur).to be true
      expect(twenty_dollars > ten_eur).to be true
      expect(twenty_dollars < fifty_eur).to be true
    end
  end
end
