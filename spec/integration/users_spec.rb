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

            response '201', "User create" do
                let(:user) { {
                    user: {
                        username: 'tester2',
                        password: '123456'
                    }
                } }
                schema allOf: [
                    {'$ref' => '#/components/schema/user'},
                    {
                        type: :object,
                        properties: {
                            token: {type: :string}
                        }
                    }
                ]
                run_test!
            end

            response '422', "Error in data" do
                let(:user) { {
                    user: {
                        password: '123456'
                    }
                } }
                schema '$ref' => '#/components/schema/errors'
                run_test!
            end

            response '422', "Error in data", document: false do
                let(:user) { {
                    user: {
                        username: '123456'
                    }
                } }
                schema '$ref' => '#/components/schema/errors'
                run_test!
            end

        end
    end
end