# frozen_string_literal: true

# Oystercard class
class Oystercard
  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1
  MINIMUM_FARE = 1
  attr_reader :balance, :entry_station, :exit_station, :journeys

  def initialize
    @balance = 0
    @journeys = []
  end

  def top_up(amount)
    # this is a guard clause to prevent exceeding max balance:
    raise 'Maximum Oystercard balance is 90' if amount + balance > MAXIMUM_BALANCE

    @balance += amount
  end

  def touch_in(station)
    raise 'Insufficient balance to touch in' if @balance < MINIMUM_BALANCE

    @in_use = true
    @entry_station = station
  end

  def touch_out(exit_station)
    deduct(MINIMUM_FARE)
    @entry_station = nil
    @exit_station = exit_station
  end

  def in_journey?
    !!entry_station
  end

  private

  def deduct(fare)
    @balance -= fare
  end
end
