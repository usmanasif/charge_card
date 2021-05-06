json.array! @cards do |card|
  json.partial! 'api/v1/cards/card', card: card
end
