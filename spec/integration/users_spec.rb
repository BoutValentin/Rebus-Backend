require 'swagger_helper.rb'

describe 'User' do
    path '/users' do
        post 'create a user' do
            tags 'User'
            description 'Create an account'
            consumes 'application/json'
            produces 'application/json'
            parameter name: :user, in: :body, scheme: {
                type: :object,
                properties: {
                    user: {type: :object, properties: {
                        username: {type: :string},
                        password: {type: :string}
                    }}
                }
            }

            response '422', "Error in data" do
                
            end

        end
    end
end