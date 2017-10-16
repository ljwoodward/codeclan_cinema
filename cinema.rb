require_relative 'models/customer.rb'
require_relative 'models/film.rb'
require_relative 'models/ticket.rb'
require_relative 'viewer.rb'

class Cinema

  def initialize(viewer)
    @viewer = viewer

    customer_name = @viewer.get_customer_name()
    customer_funds = @viewer.get_customer_funds()

    customer = Customer.new({'name' => customer_name, 'funds' => customer_funds})
    customer.save

    film_to_view = @viewer.what_film(customer)


    ticket_bought = @viewer.buy_ticket(film_to_view, customer)


  end

  def run()
    while(!@game.is_won?)
      @viewer.start(@game.current_customer.name)
      @game.next_turn(@dice.roll)
      @viewer.show_update(@game.log.last)
    end

    @viewer.end(@game.winner.name)
  end

  def run()
    @viewer.what_film
  end

end

session = Cinema.new(Viewer.new)
session.run()
