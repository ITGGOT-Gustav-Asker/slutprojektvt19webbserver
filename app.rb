require 'sqlite3'
require 'sinatra'
require 'slim'

#Startsida
get('/') do
    slim(:index)
end

get('/register') do
    slim(:register)
end

post ('/create') do
    name = params["name"]
    tel = params["tel"]
    email = params["email"]
    password = params["password"]
    db = SQLite3::Database.new("database/database.db")
    db.results_as_hash = true
    db.execute("INSERT INTO users (name, tel, email, password) VALUES (?,?,?,?)", name, tel, email, password)
    redirect('/')
end