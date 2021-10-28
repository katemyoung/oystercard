# frozen_string_literal: true

require 'oystercard'

describe Oystercard do
  context 'new card' do
    it 'has a default balance of 0' do
      expect(subject.balance).to eq(0)
    end
  end
  describe '#top_up' do
    it 'can top up the balance' do
      expect { subject.top_up(1) }.to change { subject.balance }.by(1)
    end
    it 'returns exception if balance will exceed limit' do
      maximum_balance = Oystercard::MAXIMUM_BALANCE
      expect { subject.top_up(maximum_balance + 1) }.to raise_error 'Maximum Oystercard balance is 90'
    end
  end
  describe '#deduct' do
    it 'can deduct a fare' do
      subject.top_up(20)
      expect { subject.deduct(1) }.to change { subject.balance }.by(-1)
    end
  end
end
