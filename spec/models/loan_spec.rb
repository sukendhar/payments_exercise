require 'rails_helper'

RSpec.describe Loan, type: :model do
  let(:loan) { Loan.create!(funded_amount: 100) }

  describe "remaining amount" do
    it "returns the correct remaining amount" do
      Payment.create!(loan: loan, amount: 20, date: Date.today)
      expect(loan.remaining_amount).to eq(80)
    end
  end
end
