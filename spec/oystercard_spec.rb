# frozen_string_literal: true

require 'oystercard'

describe Oystercard do
  let(:entry_station) { double :entry_station }
  let(:exit_station) { double :exit_station }
  describe '#top_up' do
    it 'tops up the balance' do
      expect { subject.top_up(1) }.to change { subject.balance }.by(1)
    end
    it 'returns exception if balance will exceed limit' do
      maximum_balance = Oystercard::MAXIMUM_BALANCE
      expect { subject.top_up(maximum_balance + 1) }.to raise_error 'Maximum Oystercard balance is 90'
    end
  end
  context 'a new card' do
    it 'has a default balance of 0' do
      expect(subject.balance).to eq(0)
    end
    it 'will not touch in if card is below minimum balance' do
      expect { subject.touch_in(entry_station) }.to raise_error 'Insufficient balance to touch in'
    end
    it 'has an empty list of journeys' do
      expect(subject.journeys).to be_empty
    end
  end
  context 'card is topped up' do
    before do
      subject.top_up(Oystercard::MAXIMUM_BALANCE)
    end
    it 'is initially not in a journey' do
      expect(subject).not_to be_in_journey
    end
    it 'on touch in it states that oystercard is in use on a journey' do
      subject.touch_in(entry_station)
      expect(subject).to be_in_journey
    end
    it 'store the entry station' do
      subject.touch_in(entry_station)
      expect(subject.entry_station).to eq entry_station
    end
    it 'on touch out states oystercard is not in use on a journey ' do
      subject.touch_in(entry_station)
      subject.touch_out(exit_station)
      expect(subject).not_to be_in_journey
    end
    it 'on touch out, balance is reduced by minimum fare' do
      minimum_fare = Oystercard::MINIMUM_FARE
      expect { subject.touch_out(exit_station) }.to change { subject.balance }.by(-minimum_fare)
    end
    it 'stores exit statio' do
      subject.touch_in(entry_station)
      subject.touch_out(exit_station)
      expect(subject.exit_station).to eq exit_station
    end
  end
end
