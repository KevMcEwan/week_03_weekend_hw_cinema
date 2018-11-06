require_relative('models/customer')
require_relative('models/film')
require_relative('models/ticket')

require('pry-byebug')

Ticket.delete_all
Film.delete_all
Customer.delete_all

customer1 = Customer.new({'name' => 'Billy', 'funds' => '20'})
customer1.save

customer2 = Customer.new({'name' => 'Jane', 'funds' => '30'})
customer2.save

customer3 = Customer.new({'name' => 'Pete', 'funds' => '45'})
customer3.save


film1 = Film.new({'title' => 'Iron Man', 'price' => '8'})
film1.save

film2 = Film.new({'title' => 'Thor', 'price' => '7'})
film2.save

film3 = Film.new({'title' => 'Avengers', 'price' => '10'})
film3.save



ticket1 = Ticket.new({'customer_id' => customer1.id, 'film_id' => film1.id})
ticket1.save

ticket2 = Ticket.new({'customer_id' => customer3.id, 'film_id' => film3.id})
ticket2.save

ticket3 = Ticket.new({'customer_id' => customer1.id, 'film_id' => film2.id})
ticket3.save



customer1.buy_ticket(customer1.id, film1)
#
# p customer1


# Customer.all
# # Film.all
# Ticket.all

# customer2.delete
# film3.delete
# ticket1.delete

# customer1.name = "William"
# customer1.update
#
# film2.title = "The Mighty Thor"
# film2.update
#
# p customer1.films_booked

# p film1.customers_booked
# p customer1.how_many_tickets
# p film1.how_many_customers

# customer1.buy_ticket(film2.price)




#
# binding.pry
# nil
