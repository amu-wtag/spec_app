# spec/factories/customers.rb

FactoryBot.define do
    factory :customer do
        name { "John Doe" }
        email { "john.doe@example.com" }
        password {"1234"}
    end
end