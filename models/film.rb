require_relative("../db/sql_runner")

class Film

  attr_reader :id, :title, :price

  def initialize( options )
    @id = options['id'].to_i
    @title = options['title']
    @price = options['price'].to_i
  end


end
