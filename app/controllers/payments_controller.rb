class PaymentsController < ApplicationController
  before_action :find_loan

  def index
    @payments = @loan.payments
    render json: @payments
  end

  def show
    @payment = @loan.payments.find(params[:id])
    render json: @payment
  end

  def create
    @payment = @loan.payments.new(payment_params)

    if @payment.save
      render json: @payment
    else
      render json: @payment.errors, status: :unprocessable_entity
    end
  end

  private

  def find_loan
    # puts params[:loan_id]
    @loan = Loan.find(params[:loan_id])
  end

  def payment_params
    params.require(:payment).permit(:amount, :date)
  end
end
