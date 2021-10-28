require 'oystercard'

describe Oystercard do
  context 'create a new card' do
    it 'has a default balance of 0' do
      expect(subject.balance).to eq(0)
    end
  end  
  context '#topup' do
    it 'balance is increased by topup amount' do
      # expect(subject.topup(1)).to eq(1)
      expect { subject.topup(1) }.to change { subject.balance }.from(0).to(1)
    end
  end
end
