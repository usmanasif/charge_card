class Api::V1::CardsController < Api::V1::BaseController
  def index
    @cards = Card.includes(:transaction_lists)
  end

  def show
    @card = Card.find_by(id: params[:id])

    render json: { message: 'Card not found' }, status: :not_found if @card.blank?
  end
end
