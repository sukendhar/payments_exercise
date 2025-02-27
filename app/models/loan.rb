class Loan < ActiveRecord::Base
  has_many :payments, dependent: :destroy

  def remaining_amount
    funded_amount - payments.sum(:amount)
  end
end
