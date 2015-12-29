require_relative "../../config/environment"

n_users = (ARGV[0] || 100).to_i

n_users.times do
  User.create!({
      first_name: Faker::Name.first_name, last_name: Faker::Name.last_name,
      email: Faker::Internet.email, password: "test1234"
    })
end