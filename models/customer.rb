require_relative("../db/sql_runner")

class Customer

  attr_reader :id, :name, :funds

  def initialize( options )
    @id = options['id'].to_i
    @name = options['name']
    @funds = options['funds'].to_i
  end

  def save()
    sql = "INSERT INTO customers
    (
      name,
      funds
    )
    VALUES
    (
      $1, $2
    )
    RETURNING id"
    values = [@name, @funds]
    cust_to_save = SqlRunner.run( sql, values ).first
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
    SqlRunner.run(sql,values)
  end


end
