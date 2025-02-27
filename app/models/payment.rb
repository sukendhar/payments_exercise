class Payment < ActiveRecord::Base
  belongs_to :loan

  validates :amount, presence: true
  validates :date, presence: true

  validate :amount_does_not_exceed

  private
  def amount_does_not_exceed
    return unless loan && amount

    if amount > loan.remaining_amount
      errors.add(:amount, "cannot exceed the remaining amount of the loan")
    end
  end
end
