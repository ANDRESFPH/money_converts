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

  describe 'operations' do
    it 'makes operations on currencies using + - * /' do
      MoneyConverts.conversion_rates('EUR', {
        'USD'     => 1.11,
        'Bitcoin' => 0.0047
      })

      fifty_euros = MoneyConverts.new(50, 'EUR')
      fifty_eur = MoneyConverts.new(50, 'EUR')
      twenty_dollars = MoneyConverts.new(20, 'USD')
      ten_eur = MoneyConverts.new(10, 'EUR')

      sum_result = fifty_eur + twenty_dollars
      sum = 50 + (20/1.11)

      subtraction_result =  fifty_eur - twenty_dollars
      subtraction = 50 - (20/1.11)

      expect((fifty_eur * 2).amount).to eq 100
      expect((fifty_eur / 2).amount).to eq 25
      expect{ fifty_eur / 0 }.to raise_error(OperationNotPossible)
      expect(sum_result.amount).to eq sum
      expect(subtraction_result.amount).to eq subtraction
    end
  end

end
