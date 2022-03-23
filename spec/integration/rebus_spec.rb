require 'swagger_helper'

describe 'Rebus' do
    path '/rebus/word?word={word}' do
        get 'Retrieve rebus from a word' do
            tags 'Rebus'
            description 'Create a rebus from the word given'
            produces 'application/json'
            parameter name: :word, in: :path, type: :string
            security [{bearer_auth:[]}]
            response '200', 'rebus create' do
                let(:Authorization) { "Bearer #{create_token({user_id: User.first.id })}" }
                let(:word) { 'bateau' }
                schema '$ref' => '#/components/schema/rebus'
                before do |t|
                    User.create(username: 'tester', password: '123456')
                end
                run_test! do |response|
                    expect(status).to eq 200
                end
            end

            response '403', 'not login' do
                let(:Authorization) { "Bearer " }
                let(:word) {'bateau'}
                schema '$ref' => '#/components/schema/errors'
                run_test!
            end
        end
    end

    path '/rebus/random' do
        get 'Create a rebus from a random word' do
            tags 'Rebus'
            description 'Create a rebus from a random word (fr)'
            produces 'application/json'
            security [{bearer_auth:[]}]
            response '200', 'rebus create' do
                let(:Authorization) { "Bearer #{JWT.encode({user_id: User.first.id}, Rails.application.credentials.config[:jwt][:key])}" }
                schema '$ref' => '#/components/schema/rebus'
                run_test!
            end

            response '403', 'not login' do
                let(:Authorization) { "Bearer " }
                schema '$ref' => '#/components/schema/errors'
                run_test!
            end
        end
    end

    path '/rebus/{id}/pass' do
        post 'Pass a rebus' do
            tags 'Rebus'
            consumes 'application/json'
            produces 'application/json'
            description 'Pass a rebus if you don\'t have this answer'
            parameter name: :id, in: :path, type: :integer
            security [{bearer_auth: []}]
            response '200', 'rebus pass' do 
                let(:Authorization) { "Bearer #{JWT.encode({user_id: User.first.id}, Rails.application.credentials.config[:jwt][:key])}" }
                let(:id) {RebusReponse.create(word: 'testing', difficulty: 0).id}
                run_test!
            end

            response '403', 'not login' do
                let(:Authorization) { "Bearer " }
                let(:id) {RebusReponse.create(word: 'testing', difficulty: 0).id}
                schema '$ref' => '#/components/schema/errors'
                run_test!
            end
        end
    end

    path '/rebus/{id}/guess' do
        post 'Guess a rebus' do
            tags 'Rebus'
            description 'Trying to guess a rebus'
            consumes 'application/json'
            produces 'application/json'
            parameter name: :id, in: :path, type: :integer
            parameter name: :guess, in: :body, type: :object, properties: {
                guess: {type: :string}
            }
            security [{bearer_auth: []}]

            response '200', 'rebus pass' do 
                let(:Authorization) { "Bearer #{JWT.encode({user_id: User.first.id}, Rails.application.credentials.config[:jwt][:key])}" }
                let(:id) {RebusReponse.create(word: 'testing', difficulty: 0).id}
                let(:guess) {{guess: 'testing'}}
                run_test!
            end

            response '403', 'not login' do
                let(:Authorization) { "Bearer " }
                let(:id) {RebusReponse.create(word: 'testing', difficulty: 0).id}
                let(:guess) {{guess: 'testing'}}
                schema '$ref' => '#/components/schema/errors'
                run_test!
            end
        end
    end
end
