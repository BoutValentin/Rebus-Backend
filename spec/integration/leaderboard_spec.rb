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
                schema type: :array, items: {'$ref' => '#/components/schema/user'}
                run_test!
            end 

            response '403', 'Not login' do
                let(:Authorization) { "Bearer " }
                schema '$ref' => '#/components/schema/errors'
                run_test!
            end
        end
    end
end
