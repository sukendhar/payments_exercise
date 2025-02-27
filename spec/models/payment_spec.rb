require 'rails_helper'

RSpec.describe Payment, type: :model do
  let(:loan) { Loan.create!(funded_amount: 100) }

  describe "validations" do
    it "is invalid without a date" do
      payment = Payment.new(loan: loan, amount: 20)
      expect(payment).not_to be_valid
      expect(payment.errors[:date]).to include("can't be blank")
    end

    it "is invalid without an amount" do
      payment = Payment.new(loan: loan, date: Date.today)
      expect(payment).not_to be_valid
      expect(payment.errors[:amount]).to include("can't be blank")
    end

    it "is invalid if the amount exceeds the remaining amount" do
      Payment.create!(loan: loan, amount: 50, date: Date.today)
      payment = Payment.new(loan: loan, amount: 60, date: Date.today)
      expect(payment).not_to be_valid
      expect(payment.errors[:amount]).to include("cannot exceed the remaining amount of the loan")
    end
  end
end
