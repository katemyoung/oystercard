require 'oystercard'

describe Oystercard do
  context 'create a new card' do
    it 'has a default balance of 0' do
      expect(subject.balance).to eq(0)
    end
  end
end
