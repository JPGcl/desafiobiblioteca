# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
estados = ["Prestado","En estante"]
def time_rand 
    from = 0.0
    to = Time.now
    Time.at(from + rand * (to.to_f - from.to_f))
end
100.times do |i|
    Book.create(title: "Libro #{i}", author: "Author #{i}", loan_date: time_rand(), return_date: time_rand(),  status: estados[rand(2)])
end
