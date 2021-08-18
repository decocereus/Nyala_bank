# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
gbp = Currency.create(isoCode: "GBP", valueInPounds: 1, symbol: "£")
eur = Currency.create(isoCode: "EUR", valueInPounds: 0.91, symbol: "€")
eur = Currency.create(isoCode: "USD", valueInPounds: 0.75, symbol: "$")

User.create(email: "k19026058@kcl.ac.uk", first_name: "Daniel", last_name: "Chakaveh-Roberts", date_of_birth: Date.new(2000, 12, 19), phone: "07954681893", password:"password123", password_confirmation: "password123", balance: 1523.32)
jack = User.new(email: "jack.smith@gmail.com", first_name: "Jack", last_name: "Smith", date_of_birth: Date.new(1975, 04, 13), phone: "07294518321", password:"topsecret", password_confirmation: "topsecret", balance: 23.12)
User.create(email: "harry.peters@yahoo.com", first_name: "Harry", last_name: "Peters", date_of_birth: Date.new(1995, 01, 01), phone: "07369462852", password:"myPassword", password_confirmation: "myPassword").id
jack.save

Transaction.create(sender:User.where(:email => "k19026058@kcl.ac.uk").first, amount:15.65, currency:gbp, recipient_name:"Jack Smith", sort_code:"050505", account_number:jack.id)
AdminUser.create!(email: 'admin@Nyalabank.com', password: 'Superman', password_confirmation: 'Superman')
