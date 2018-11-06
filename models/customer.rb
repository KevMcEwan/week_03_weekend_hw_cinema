require_relative("../db/sql_runner")


class Customer

  attr_reader :id
  attr_accessor :name, :funds

  def initialize( options )
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @funds = options['funds'].to_i
  end

  def save()
    sql = "INSERT INTO customers (name, funds) VALUES ($1, $2) RETURNING id"
    values = [@name, @funds]
    customer = SqlRunner.run(sql, values).first
    @id = customer['id'].to_i
  end

  def self.delete_all
    sql = "DELETE FROM customers"
    SqlRunner.run(sql)
  end

  def delete()
    sql = "DELETE FROM customers WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def update()
    sql = "UPDATE customers SET (name, funds) = ($1, $2) WHERE id = $3"
    values = [@name, @funds, @id]
    SqlRunner.run(sql, values)
  end

  def self.all()
    sql = "SELECT * FROM customers"
    results = SqlRunner.run(sql)
    customer_data = results.map {|customer| Customer.new(customer)}
    return customer_data
  end

  def films_booked
    sql = "SELECT films.title
    FROM films
    INNER JOIN tickets
    ON tickets.film_id = films.id
    WHERE customer_id = $1"
    values = [@id]
    results = SqlRunner.run(sql, values)
    customer_bookings = results.map{|booking| Film.new(booking)}
    return customer_bookings
  end

  def how_many_tickets
    sql = "SELECT films.title
    FROM films
    INNER JOIN tickets
    ON tickets.film_id = films.id
    WHERE customer_id = $1"
    values = [@id]
    results = SqlRunner.run(sql, values)
    customer_bookings = results.map{|booking| Film.new(booking)}
    return customer_bookings.count
  end



  def buy_ticket(customer_id,film)
    if @funds > film.price
      Ticket.new({'customer_id' => customer_id, 'film_id' => film.id})
      sql = "UPDATE customers SET (name, funds) = ($1, $2) WHERE id = $3"
      values = [@name, @funds-film.price, @id]
      SqlRunner.run(sql, values)
      sql = "INSERT INTO tickets (customer_id, film_id) VALUES ($1, $2) RETURNING id"
      values = [customer_id, film.id]
      ticket = SqlRunner.run(sql, values).first
      @id = ticket['id'].to_i
    end
  end







end
