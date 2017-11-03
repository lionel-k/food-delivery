class Order
  attr_accessor :id
  attr_reader :meal, :employee, :customer

  def initialize(attributes = {})
    @customer = attributes[:customer]
    @meal = attributes[:meal]
    @employee = attributes[:employee]
    @delivered = attributes[:delivered] || false
    @id = attributes[:id]
  end

  def deliver!
    @delivered = true
  end

  def delivered?
    @delivered
  end
end
