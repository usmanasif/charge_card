class Api::V1::TransactionsController < Api::V1::BaseController
  before_action :set_card, only: [:index]

  def index
    @transactions = @card&.transaction_lists&.approved || TransactionList.approved
    limit = params[:limit] || 10
    offset = params[:offset] || 0

    @transactions = @transactions.order(:created_at).limit(params[:limit]).offset(params[:offset])
  end

  private
    def set_card
      @card = Card.find(params[:card_id])

    rescue
      render json: { message: 'Please enter a valid card_id' }, status: :not_found if params[:card_id] && @card.blank?
    end
end
