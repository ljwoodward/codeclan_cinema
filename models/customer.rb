require_relative("../db/sql_runner")
require_relative("film.rb")

class Customer

  attr_reader :id
  attr_accessor :name, :funds

  def initialize( options )
    @id = options['id'].to_i
    @name = options['name']
    @funds = options['funds'].to_i
    @tickets_purchased = 0
  end

  def save()
    sql = "INSERT INTO customers
    (
      name,
      funds,
      tickets_purchased
    )
    VALUES
    (
      $1, $2, $3
    )
    RETURNING id"
    values = [@name, @funds, @tickets_purchased]
    cust_to_save = SqlRunner.run(sql, values)[0]
    @id = cust_to_save['id'].to_i
  end

  def self.delete_all()
    sql = "DELETE FROM customers"
    values = []
    SqlRunner.run(sql, values)
  end

  def self.all()
    sql = "SELECT * FROM customers"
    values = []
    customer_array = SqlRunner.run(sql, values)
    result = customer_array.map { |customer| Customer.new( customer ) }
    return result
  end

  def delete()
    sql = "DELETE FROM customers WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def update()
    sql = "UPDATE customers SET (name, funds, tickets_purchased) = ($1, $2, $3) WHERE id = $4"
    values = [@name, @funds, @tickets_purchased, @id]
    SqlRunner.run(sql, values)
  end

  def films()
    sql = "SELECT films.* FROM films
          INNER JOIN tickets
          ON films.id = tickets.film_id
          Where customer_id = $1;"
    values = [@id]
    film_array = SqlRunner.run(sql, values)
    results = film_array.map { |item| Film.new(item) }
    return results
  end

  def purchase_ticket(film)
    if film.tickets_available == 0
      return "Sorry, this film is fully booked"
    elsif @funds > film.price
      @funds -= film.price
      film.tickets_available -= 1
      @tickets_purchased += 1
      your_ticket = Ticket.new({ 'customer_id' => @id, 'film_id' => film.id })
      your_ticket.save
      film.update
      self.update
      return your_ticket
    else
      return "Sorry, you have insufficient funds to purchase this ticket"
    end
  end


end
