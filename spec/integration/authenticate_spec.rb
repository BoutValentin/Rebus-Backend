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
                
                schema type: :object, properties: {
                        id: {type: :integer},
                        username: { type: :string },
                        points:  {type: :integer},
                        created_at: { type: :string },
                        updated_at: { type: :string },
                        url: { type: :string },
                        token: { type: :string }        
                }
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
                schema type: :object, properties: {
                    message: {type: :string}       
                }

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
                schema type: :object, properties: {
                    message: {type: :string}       
                }
                before do |exemple|
                    User.create(username: 'tester', password: '123456')
                end

                run_test! do |response|
                    item = JSON.parse(response.body)
                    expect(item['token']).to be_nil
                    expect(status).to eq 403
                end
            end
        end
    end
end

# resource "Authenticate v1.1" do
#     header "Accept", "application/json"
#     header "Content-Type", "application/json"
    

#     route '/login', 'Login User' do
#         attribute :username, "Username", :required => true
#         attribute :password, "Password", :required => true
        
#         post "Login" do
#             let(:password) { '123456' }
#             let(:request) {{ username: username, password: password }}
#             let(:raw_post) { params.to_json }
#             context 'with valid data' do
#                 let(:username) { User.first.username }
#                 example 'Login successfull' do
#                     do_request(request)
#                     item = JSON.parse(response_body)
#                     item["token"].should_not be_nil
#                     item["token"].should_not be_empty
#                     expect(status).to eq 200
#                 end
#             end

#             context 'with invalid username' do 
#                 let(:username) {"invalid"}
#                 example 'Login unsucessfull with invalid username' do 
#                     do_request(request)
#                     item = JSON.parse(response_body)
#                     item["token"].should be_nil
#                     expect(status).to eq 403
#                 end
#             end

#             context 'with invalid password' do 
#                 let(:username) { User.first.username }
#                 let(:password) {'invalid'}
#                 example 'Login unsucessfull with invalid password' do 
#                     do_request(request)
#                     item = JSON.parse(response_body)
#                     item["token"].should be_nil
#                     expect(status).to eq 403
#                 end
#             end
#         end
#     end
# end
  