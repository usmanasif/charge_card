class Api::V1::TransactionListsController < Api::V1::BaseController
  before_action :set_card, only: [:index]

  def index
    @transaction_lists = @card.transaction_lists
    limit = params[:limit] || 10
    offset = params[:offset] || 0

    @transaction_lists = @transaction_lists.order(:created_at).limit(params[:limit]).offset(params[:offset])
  end

  def show
    @transaction_list = TransactionList.find_by(id: params[:id])

    render json: { message: 'Transaction not found' }, status: :not_found if @transaction_list.blank?
  end

  private

    def set_card
      @card = Card.find(params[:card_id])

    rescue
      render json: { message: 'Please pass a valid card_id' }, status: :not_found if @card.blank?
    end
end
