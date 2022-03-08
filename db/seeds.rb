# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
(('a'..'z').to_a() + ['à', 'á', 'é', 'è']).each do |value|
    icon = Icon.create(name: value)
    icon.image.attach(io: File.open(Rails.root.join("app/assets/images/phonetic/#{value.upcase}.png")), filename: "#{value}.png")

    phonetic = Phonetic.create(phonetic: value)
    phonetic.direct_phonetic_icons = [icon]

    syllable = SyllableLetter.create(syllable_letter: value, phonetic: phonetic)
end

user = User.create(username: "Perceval", password: "123456")
user2 = User.create(username: "Gluburuk", password: "123456")
user3 = User.create(username: "Ayoub", password: "123456")

rebus = RebusReponse.create(word: "bateau", difficulty: 10)