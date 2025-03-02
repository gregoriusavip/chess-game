# frozen_string_literal: true

# prompts for user's inputs
module Prompts
  def promo_prompt
    promo_list = { 'knight' => Knight, 'bishop' => Bishop, 'rook' => Rook, 'queen' => Queen }
    loop do
      print 'Input the piece (rook/bishop/knight/queen)'
      input = gets.chomp
      return promo_list[input] if promo_list.include?(input)
    end
  end
end
