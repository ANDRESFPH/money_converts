require_relative 'spec_helper'

describe MoneyConverts do
  describe '.convert_to' do
    it 'converts from eur to usd' do

      MoneyConverts.conversion_rates('EUR', {
        'USD'     => 1.11,
        'Bitcoin' => 0.0047
      })

      fifty_euros = MoneyConverts.new(50, 'EUR');

      result = 50 * 1.11

      expect(fifty_euros.convert_to('USD').amount).to eq result
    end
  end
end
