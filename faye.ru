# runs faye; requires thin
# usage rackup faye.ru -s thin -E production
require ::File.expand_path('../config/environment', __FILE__)
require 'faye'
bayeux = Faye::RackAdapter.new(:mount => '/faye', :timeout => 25)
run bayeux
