require 'swagger_helper'
require 'jwt_helper'

describe 'Leaderboard' do
    path '/leaderboard' do
        get 'Retrieve the leaderboard' do
            tags 'Leaderboard'
            description 'Retrieve the 100 best players in the rebus game.'
            consumes 'application/json'
            produces 'application/json'
            security [{bearer_auth:[]}]
            
            response '200', 'Get leaderboard' do
                let(:Authorization) { "Bearer #{create_token({user_id: User.first.id})}"}
                schema type: :array, items: {
                    type: :object, 
                    properties: {
                        id: {type: :integer},
                        username:  {type: :string},
                        points:  {type: :integer},
                        created_at:  {type: :string},
                        updated_at:  {type: :string},
                        url:  {type: :string}   
                    }
                }
                run_test!
            end 

            response '403', 'Not login' do
                let(:Authorization) { "Bearer " }
                schema type: :object, properties: {
                    message: {type: :string}       
                }
                run_test!
            end
        end
    end
end
