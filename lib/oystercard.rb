# frozen_string_literal: true

# Oystercard class
class Oystercard
  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1
  MINIMUM_FARE = 1
  attr_reader :balance

  def initialize
    @balance = 0
  end

  def top_up(amount)
    # this is a guard clause to prevent exceeding max balance:
    raise 'Maximum Oystercard balance is 90' if amount + balance > MAXIMUM_BALANCE

    @balance += amount
  end

  def touch_in
    raise 'Insufficient balance to touch in' if @balance < MINIMUM_BALANCE

    @in_use = true
  end

  def touch_out
    deduct(MINIMUM_FARE)
    @in_use = false
  end

  def in_journey?
    @in_use
  end

  private

  def deduct(fare)
    @balance -= fare
  end
end
