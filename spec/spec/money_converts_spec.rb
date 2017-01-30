require_relative 'spec_helper'

describe MoneyConverts do
  MoneyConverts.conversion_rates('EUR', {
    'USD'     => 1.11,
    'Bitcoin' => 0.0047
  })
  describe '.convert_to' do
    context 'on succes' do
      it 'converts from a currency to another' do

        fifty_euros = MoneyConverts.new(50, 'EUR')
        twenty_dollars = MoneyConverts.new(20, 'USD')

        eur_to_dollar = 50 * 1.11
        dollar_to_eur = 20 / 1.11
        dollar_to_bitcoin = 20 / 1.11 * 0.0047

        expect(fifty_euros.convert_to('USD').amount).to eq eur_to_dollar
        expect(twenty_dollars.convert_to('EUR').amount).to eq dollar_to_eur
        expect(twenty_dollars.convert_to('Bitcoin').amount).to eq dollar_to_bitcoin
        expect(twenty_dollars.convert_to('EUR').inspect).to eq "18.02 EUR"
      end
    end

    context 'failure' do
      it 'fails if the currency to convert does not exists' do
        fifty_euros = MoneyConverts.new(50, 'EUR')
        expect {fifty_euros.convert_to('COP') }.to raise_error(NoConversionForCurrency)
      end
    end
  end

  describe 'comparisons' do
    context 'on succes' do
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

  describe 'operations' do
    context 'on succes' do
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
        expect(sum_result.amount).to eq sum
        expect(subtraction_result.amount).to eq subtraction
      end
    end

    context 'failure' do
      it 'raises an error if the division is by cero' do
        fifty_eur = MoneyConverts.new(50, 'EUR')
        expect{ fifty_eur / 0 }.to raise_error(OperationNotPossible)
      end

      it 'raises an error if it tries to add or subtract a Numeric to a currency' do
        fifty_eur = MoneyConverts.new(50, 'EUR')
        expect{ fifty_eur + 3 }.to raise_error(OperationNotPossible)
        expect{ fifty_eur - 3 }.to raise_error(OperationNotPossible)
      end
    end
  end

end
