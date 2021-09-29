# frozen_string_literal: true

require 'matrix'

require_relative './controllers/game'

game = GameController.new
# game.printBoard
game.player_turn until game.loss
