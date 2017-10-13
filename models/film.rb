require_relative("../db/sql_runner")

class Film

  attr_reader :id, :title, :price

  def initialize( options )
    @id = options['id'].to_i
    @title = options['title']
    @price = options['price'].to_i
  end

  def save()
    sql = "INSERT INTO films
    (
      title,
      price
    )
    VALUES
    (
      $1, $2
    )
    RETURNING id"
    values = [@title, @price]
    film_to_save = SqlRunner.run( sql, values ).first
    @id = film_to_save['id'].to_i
  end

  def self.delete_all()
    sql = "DELETE FROM films"
    values = []
    SqlRunner.run(sql, values)
  end


end
