require_relative("../db/sql_runner")
require_relative("film.rb")
require_relative("customer.rb")

class Ticket

  attr_reader :id, :customer_id, :film_id

  def initialize( options )
    @id = options['id'].to_i
    @customer_id = options['customer_id'].to_i
    @film_id = options['film_id'].to_i
  end

  def save()
    sql = "INSERT INTO tickets
    (
      customer_id,
      film_id
    )
    VALUES
    (
      $1, $2
    )
    RETURNING id"
    values = [@customer_id, @film_id]
    tickets = SqlRunner.run( sql,values ).first
    @id = tickets['id'].to_i
  end

  def self.delete_all()
    sql = "DELETE FROM tickets"
    values = []
    SqlRunner.run(sql, values)
  end

  def self.all()
    sql = "SELECT * FROM tickets"
    values = []
    ticket_array = SqlRunner.run(sql, values)
    result = ticket_array.map { |ticket| Ticket.new(ticket) }
    return result
  end

  def delete()
    sql = "DELETE FROM tickets WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql,values)
  end

  def film
    sql = "SELECT * FROM films
    WHERE id = $1"
    values = [@film_id]
    results = SqlRunner.run(sql, values)
    return Film.new(results[0])
  end

  def customer
    sql = "SELECT * FROM customers
    WHERE id = $1"
    values = [@customer_id]
    result = SqlRunner.run(sql, values)[0]
    return Customer.new(result)
  end


end
