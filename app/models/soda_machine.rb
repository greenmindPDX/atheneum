require 'rubygems'
require 'state_machine'

class SodaTransaction

	attr_accessor :selection
	state_machine :state, initial: :awaiting_selection do

    	event :button_press do
      		transition :awaiting_selection => :dispense_soda, if: :in_stock?
    	end
    	event :soda_dropped do
      		transition :dispense_soda => :complete
    	end
  	end

	def button_press(selection)
    	@selection = selection.to_sym
    	super
  	end

	def in_stock?
    	stock_levels[@selection.to_sym] > 0
  	end

	def stock_levels
    	{
      	dr_pepper: 100,
      	sprite: 10,
      	root_beer: 0,
      	cola: 8
    	}
  	end
end