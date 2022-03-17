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
                schema type: :object, properties: {
                    message: {type: :string}       
                }
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
                run_test!
            end

            response '403', 'not login' do
                let(:Authorization) { "Bearer " }
                schema type: :object, properties: {
                    message: {type: :string}       
                }
                run_test!
            end
        end
    end
end
