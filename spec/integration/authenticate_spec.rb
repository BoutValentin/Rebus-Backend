require 'swagger_helper'

describe 'Authentication' do
    path '/login' do
        post 'Login as user' do
            tags 'Login'
            description 'Try to log an user depending on the data your sent'
            consumes 'application/json'
            produces 'application/json'
            parameter name: :user, in: :body, schema: {
                type: :object,
                properties: {
                username: { type: :string },
                password: { type: :string }
                },
                required: [ 'username', 'password' ]
            }

            response '200', 'login sucessfull' do 
                let(:user) {{username: 'tester', password: '123456'}}
                
                schema '$ref' => '#/components/schema/user'
                before do |exemple|
                    User.create(username: 'tester', password: '123456')
                end
                run_test! do |response|
                    item = JSON.parse(response.body)
                    expect(item['token']).not_to be_nil
                    expect(item['token']).not_to be_empty
                    expect(status).to eq 200
                end
            end

            response '403', 'invalid username and password' do
                schema '$ref' => '#/components/schema/errors'

                let(:user) {{username: 'invalid', password: '123456'}}
                
                before do |exemple|
                    User.create(username: 'tester', password: '123456')
                end

                run_test! do |response|
                    item = JSON.parse(response.body)
                    expect(item['token']).to be_nil
                    expect(status).to eq 403
                end
               
            end

            response '403', 'invalid password', document: false do
                let(:user) {{username: 'tester', password: 'invalid'}}
                schema '$ref' => '#/components/schema/errors'
                before do |exemple|
                    User.create(username: 'tester', password: '123456')
                end

                run_test! do |response|
                    item = JSON.parse(response.body)
                    expect(item['token']).to be_nil
                    expect(status).to eq 403
                end
            end

            response '422', "Error in data" do
                let(:user) {{ password: '123456' }}
                schema '$ref' => '#/components/schema/errors'
                run_test!
            end

            response '403', "No password provide", document: false do
                let(:user) {{ username: 'tester' }}
                before do |exemple|
                    User.create(username: 'tester', password: '123456')
                end
                schema '$ref' => '#/components/schema/errors'
                run_test!
            end
        end
    end
end
