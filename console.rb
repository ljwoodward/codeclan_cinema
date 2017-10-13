require_relative( 'models/customer.rb' )
require_relative( 'models/film.rb' )
require_relative( 'models/ticket.rb' )
require( 'pry' )


Ticket.delete_all()
Film.delete_all()
Customer.delete_all()

customer1 = Customer.new({ 'name' => 'Boris Johnson', 'funds' => 250 })
customer1.save()
customer2 = Customer.new({ 'name' => 'Barry Chuckle', 'funds' => 25 })
customer2.save()

film1 = Film.new({ 'title' => 'Requiem for a Dream', 'price' => 15})
film1.save()
film2 = Film.new({ 'title' => 'My Little Pony: Bigger, Longer, Uncut', 'price' => 12})
film2.save()

ticket1 = Ticket.new({ 'customer_id' => customer1.id, 'film_id' => film1.id })
ticket1.save()
ticket2 = Ticket.new({ 'customer_id' => customer2.id, 'film_id' => film1.id })
ticket2.save()
ticket3 = Ticket.new({ 'customer_id' => customer1.id, 'film_id' => film2.id })
ticket3.save()

binding.pry
nil
