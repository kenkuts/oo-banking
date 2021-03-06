class Transfer
  attr_reader :sender
  attr_accessor :status, :receiver, :amount

  def initialize(sender, receiver, amount)
    @sender = sender
    @receiver = receiver
    @amount = amount
    @status = "pending"
  end

  def valid?
     @sender.valid? && @receiver.valid?
  end

  def execute_transaction
    if @status == "pending" && self.valid? && @sender.balance > @amount
      @sender.balance -= @amount
      @receiver.balance += @amount
      @status = "complete"
    else
      reject_transfer
    end
  end
  

  def reverse_transfer
    if @status == "complete" && @receiver.balance > @amount && self.valid?
      @sender.balance += @amount
      @receiver.balance -= @amount
      @status = "reversed"
    else
      reject_transfer
    end
  end

  def reject_transfer
    @status = "rejected"
    "Transaction rejected. Please check your account balance."
  end
end
