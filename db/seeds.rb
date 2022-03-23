# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

# Creating the minimum letter needed to create a rebus
(('a'..'z').to_a() + ['à', 'á', 'é', 'è']).each do |value|
    icon = Icon.create(name: value)
    icon.image.attach(io: File.open(Rails.root.join("app/assets/images/phonetic/#{value.upcase}.png")), filename: "#{value}.png")

    phonetic = Phonetic.create(phonetic: value)
    phonetic.direct_phonetic_icons = [icon]

    syllable = SyllableLetter.create(syllable_letter: value, phonetic: phonetic)
end

# Creating some user of our application
tester = User.create(username: "tester", password: "123456")
user = User.create(username: "perceval", password: "123456")
user2 = User.create(username: "gluburuk", password: "123456")
user3 = User.create(username: "ayoub", password: "123456")

# Creating a simple response
rebus = RebusReponse.create(word: "bateau", difficulty: 10)
