class CreateApplication < ActiveRecord::Migration
	def change
		create_table :applications do |t|
    		t.string :best_film
    		t.text   :community_role 
    		t.string :conversation_starter
    		t.text	 :essential_to_writing #essay on how this will benefit your writing.
    		t.string :family_hero
    		t.string :favorite_quiet_meal
    		t.string :fiction_character
    		t.string :film_character
    		t.string :genre 				#fiction, poetry, etc
    		t.string :head_turner
    		t.string :location_reference	#letter of reco file location
    		t.string :location_sample		#writing sample file location
    		t.string :personality_word
    		t.string :political_hero
    		t.string :status				#status of this application
    		t.string :studied_with 
    		t.string :time_period
    		t.timestamps
    	end
	end
end
=begin
~ Your favorite fictional character: Books.
~ Your favorite fictional character: Films.
~ Best 3 films.
~ Favorite food for a quiet dinner.
~ If you could have lived in another time period, which one?
~ Name a political hero.
~ Name a family hero.
~ Your best conversation starter.
~ Surprising conversation head-turner about you.	
	
=end
