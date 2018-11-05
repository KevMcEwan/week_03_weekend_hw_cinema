require_relative('../db/sql_runner')

class Film

  attr_reader :id
  attr_accessor :title, :price

  def initialize( options )
    @id = options['id'].to_i if options['id']
    @title = options['title']
    @price = options['price'].to_i
  end

  def save()
    sql = "INSERT INTO films (title, price) VALUES ($1, $2) RETURNING id"
    values = [@title, @price]
    film = SqlRunner.run(sql, values).first
    @id = film['id'].to_i
  end


  def self.delete_all
    sql = "DELETE FROM films"
    SqlRunner.run(sql)
  end

  def delete()
    sql = "DELETE FROM films WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def update()
    sql = "UPDATE films SET (title, price) = ($1, $2) WHERE id = $3"
    values = [@title, @price, @id]
    SqlRunner.run(sql, values)
  end

  def self.all()
    sql = "SELECT * FROM films"
    results = SqlRunner.run(sql)
    film_data = results.map {|film| Film.new(film)}
    return film_data
  end

  def customers_booked
    sql = "SELECT customers.name
    FROM customers
    INNER JOIN tickets
    ON tickets.customer_id = customers.id
    WHERE film_id = $1"
    values = [@id]
    results = SqlRunner.run(sql, values)
    customers_booked = results.map{|booking| Customer.new(booking)}
    return customers_booked
  end

  def how_many_customers
    results = customers_booked.count
  end

  def find_film
    sql = "SELECT title FROM films WHERE id = $1"
    values = [@id]
    result = SqlRunner.run(sql, values)
    p result
  end

end
