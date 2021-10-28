# frozen_string_literal: true

# Oystercard class
class Oystercard
  MAXIMUM_BALANCE = 90
  attr_reader :balance

  def initialize
    @balance = 0
  end

  def top_up(amount)
    # this is a guard clause to prevent exceeding max balance:
    raise 'Maximum Oystercard balance is 90' if amount + balance > MAXIMUM_BALANCE

    @balance += amount
  end

  def deduct
  end
end
