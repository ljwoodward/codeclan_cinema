require_relative('db/sql_runner.rb')
require_relative('models/film.rb')
require_relative('models/customer.rb')

class Viewer

  def get_customer_name()
    puts "Welcome to Codeclan Cinema. Please enter your name:"
    return gets.chomp
  end

  def get_customer_funds()
    puts "If you don't mind me asking, how much money do you have?"
    puts "(enter number of pounds)"
    return gets.chomp
  end

  def what_film(customer)
    films = Film.all
    film_names = films.map { |film| film.title  }
    puts "Thanks, #{customer.name}"
    film_names.each_with_index { |film, index| puts "for #{film}, enter '#{index}.''"}
    puts "Which would you like to view?"
    film_index = gets.chomp
    return film_names[film_index.to_i()]
  end

  def buy_ticket(film, customer)
    puts "Would you like to purchase a ticket for #{film}?"
    answer = gets.chomp
    if answer.downcase! == "yes"
      customer.purchase_ticket(film)
      return customer
    elsif answer.downcase! == "no"
      return self.what_film(customer)
    else
      puts "please answer 'yes' or 'no'."

    end
    # else puts
    # return customer
  end

  # def show_update(entry)
  #   puts "#{entry.customer.name} rolled #{entry.roll}"
  #   if(entry.modifier != 0)
  #     puts "#{entry.customer.name} hit a #{entry.modifier_type}! Moves #{entry.modifier}"
  #   end
  #   puts "#{entry.customer.name} is on tile #{entry.customer.position}"
  # end
  #
  # def end(winner_name)
  #   puts "Congratulations, #{winner_name} wins"
  # end
end
