require 'game'
require "grid"
require 'cell'
require "player"

describe Game do

	let(:player_1)     { double :player, ships: destroyer, grid: nil, all_ships_sunk?: nil , name: "Rihanna" 	}
	let(:player_2)     { double :player, ships: destroyer, grid: nil, name: "Albert" 	    }
	let(:destroyer)   { double :ship                     }
	let(:game)		    { Game.new(player_1.name, player_2.name)			}
	let(:score)		{double :score}


	it "should initialize 2 players" do		
		expect(game.player_1).to be_a(Player)   
		expect(game.player_2).to be_a(Player) 
	end

	it "should give the players ids" do
		expect(game.player_1.id).to eq "player_1"
		expect(game.player_2.id).to eq "player_2"
	end



	it "should be player1's turn" do

		expect(game.turn.name).to eq player_1.name

	end
	
	it "at the beginning player_2 is going to be the opponent" do
		expect(game.opponent.name).to eq player_2.name
	end

	it "should be able to place a ship for a player" do
		expect(player_1.grid).to receive(:place).with game.player_1.ships[:destroyer], "A1", "vertically"
		game.place(game.player_1.ships[:destroyer], player_1,"A1", "vertically")
	end


	it "should allow a player to take a shot" do
		allow(player_2.grid).to receive(:hit).with("B2")
		game.shoot("B2")
	end

	# it "should ask if player_1 has won" do
	# 	allow(score).to receive(:winner?).with(game.turn).and_throw(true)
	# 	expect(game.shoot("A1")).to eq ("#{game.turn.name} has won the game!")
	# end


	it "should switch to player_2's turn after player_1 takes a shot" do
	 	allow(player_2.grid).to receive(:hit).with("B2")
		game.shoot("B2")
		expect(game.turn.name).to eq player_2.name
	end

	it "should change the opponent after a turn is finished" do
		game.switch_turn
		expect(game.opponent).to be game.player_1
	end	

end