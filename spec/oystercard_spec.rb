# frozen_string_literal: true

require 'oystercard'

describe Oystercard do
  context 'new card' do
    it 'has a default balance of 0' do
      expect(subject.balance).to eq(0)
    end
  end
  describe '#top_up' do
    it 'tops up the balance' do
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
  describe '#touch_in' do
    it 'can touch in' do
      expect(subject).to respond_to(:touch_in)
    end
  end
  describe '#touch_out' do
    it 'can touch out' do
      expect(subject).to respond_to(:touch_out)
    end
  end
  context 'card is topped up' do
    before do
      subject.top_up(Oystercard::MAXIMUM_BALANCE)
    end
    it 'is initially not in a journey' do
        expect(subject).not_to be_in_journey
    end 
    it 'on touch in states that oystercard is in use on a journey' do
        subject.touch_in
        expect(subject).to be_in_journey
      end
    it 'on touch out states oystercard is not in use on a journey ' do
        subject.touch_in
        subject.touch_out
        expect(subject).not_to be_in_journey
    end
  end
  context 'card is not topped up' do
    it 'will not touch in if card is below minimum balance' do
      expect { subject.touch_in }.to raise_error "Insufficient balance to touch in"
    end
  end
end

