require_relative("../db/sql_runner")
require_relative("customer.rb")

class Film

  attr_reader :id
  attr_accessor :title, :price, :tickets_available

  def initialize( options )
    @id = options['id'].to_i
    @title = options['title']
    @price = options['price'].to_i
    @tickets_available = options['tickets_available'].to_i
  end

  def save()
    sql = "INSERT INTO films
    (
      title,
      price,
      tickets_available
    )
    VALUES
    (
      $1, $2, $3
    )
    RETURNING id"
    values = [@title, @price, @tickets_available]
    film_to_save = SqlRunner.run( sql, values ).first
    @id = film_to_save['id'].to_i
  end

  def self.delete_all()
    sql = "DELETE FROM films"
    values = []
    SqlRunner.run(sql, values)
  end

  def self.all()
    sql = "SELECT * FROM films"
    values = []
    film_array = SqlRunner.run(sql, values)
    result = film_array.map { |film| Film.new(film)  }
    return result
  end

  def delete()
    sql = "DELETE FROM films WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql,values)
  end

  def update()
    sql = "UPDATE films SET (title, price, tickets_available) = ($1, $2, $3) WHERE id = $4"
    values = [@title, @price, @tickets_available, @id]
    SqlRunner.run(sql, values)
  end

  def customers()
    sql = "SELECT customers.* FROM customers
          INNER JOIN tickets
          ON customers.id = tickets.customer_id
          Where customer_id = $1;"
    values = [@id]
    customer_array = SqlRunner.run(sql, values)
    results = customer_array.map { |item| Customer.new(item) }
    return results
  end


end
