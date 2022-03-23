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

# Many eau icon
icon_eau_1 = Icon.create(name: 'eau')
icon_eau_1.image.attach(io: File.open(Rails.root.join("app/assets/images/phonetic/eau2.jpg")), filename: "eau2.jpg")
icon_eau_2 = Icon.create(name: 'eau')
icon_eau_2.image.attach(io: File.open(Rails.root.join("app/assets/images/phonetic/eau1.webp")), filename: "eau1.webp")
icon_eau_3 = Icon.create(name: 'eau')
icon_eau_3.image.attach(io: File.open(Rails.root.join("app/assets/images/phonetic/eau3.jpg")), filename: "eau3.jpg")
# Retrieve phonetic with it
phonetic_o = Phonetic.find_by(phonetic: 'o')
# Add icon to it
phonetic_o.direct_phonetic_icons << icon_eau_1
phonetic_o.direct_phonetic_icons << icon_eau_2
phonetic_o.direct_phonetic_icons << icon_eau_3
# Associate syllable to o phonetic
syllable_eau = SyllableLetter.create(syllable_letter: 'eau', phonetic: phonetic_o)
syllable_eau = SyllableLetter.create(syllable_letter: 'au', phonetic: phonetic_o)
syllable_eau = SyllableLetter.create(syllable_letter: 'haut', phonetic: phonetic_o)

# ba
icon_ba = Icon.create(name: 'ba')
icon_ba.image.attach(io: File.open(Rails.root.join("app/assets/images/phonetic/bas.jpg")), filename: "bas.jpg")
phonetic_bas = Phonetic.create(phonetic: 'ba')
phonetic_bas.direct_phonetic_icons = [icon_ba]
syllable_ba = SyllableLetter.create(syllable_letter: 'ba', phonetic: phonetic_bas)
syllable_bas = SyllableLetter.create(syllable_letter: 'bas', phonetic: phonetic_bas)
syllable_bah = SyllableLetter.create(syllable_letter: 'bah', phonetic: phonetic_bas)

# to
icon_to = Icon.create(name: 'tot')
icon_to.image.attach(io: File.open(Rails.root.join("app/assets/images/phonetic/tot.jpg")), filename: "tot.jpg")
phonetic_to = Phonetic.create(phonetic: 'to')
phonetic_to.direct_phonetic_icons = [icon_to]
syllable_to = SyllableLetter.create(syllable_letter: 'teau', phonetic: phonetic_to)
syllable_to = SyllableLetter.create(syllable_letter: 'tot', phonetic: phonetic_to)
syllable_to = SyllableLetter.create(syllable_letter: 'taux', phonetic: phonetic_to)
syllable_to = SyllableLetter.create(syllable_letter: 'tau', phonetic: phonetic_to)
syllable_to = SyllableLetter.create(syllable_letter: 'to', phonetic: phonetic_to)

# ta
icon_ta = Icon.create(name: 'ta')
icon_ta.image.attach(io: File.open(Rails.root.join("app/assets/images/phonetic/tas.jpg")), filename: "tas.jpg")
phonetic_tas = Phonetic.create(phonetic: 'ta')
phonetic_tas.direct_phonetic_icons = [icon_ta]
syllable_ta = SyllableLetter.create(syllable_letter: 'ta', phonetic: phonetic_tas)
syllable_tas = SyllableLetter.create(syllable_letter: 'tas', phonetic: phonetic_tas)

# le
icon_lait = Icon.create(name: 'lait')
icon_lait.image.attach(io: File.open(Rails.root.join("app/assets/images/phonetic/lait.jpg")), filename: "lait.jpg")
phonetic_le = Phonetic.create(phonetic: 'lé')
phonetic_le.direct_phonetic_icons = [icon_lait]
syllable_lait = SyllableLetter.create(syllable_letter: 'lait', phonetic: phonetic_le)
syllable_laid = SyllableLetter.create(syllable_letter: 'laid', phonetic: phonetic_le)
syllable_les = SyllableLetter.create(syllable_letter: 'les', phonetic: phonetic_le)
syllable_lé = SyllableLetter.create(syllable_letter: 'lé', phonetic: phonetic_le)

# go
icon_go = Icon.create(name: 'go')
icon_go.image.attach(io: File.open(Rails.root.join("app/assets/images/phonetic/go.jpg")), filename: "go.jpg")
phonetic_go = Phonetic.create(phonetic: 'go')
phonetic_go.direct_phonetic_icons = [icon_go]
syllable_go = SyllableLetter.create(syllable_letter: 'go', phonetic: phonetic_go)
#risoto
icon_risoto = Icon.create(name: 'risoto')
icon_risoto.image.attach(io: File.open(Rails.root.join("app/assets/images/phonetic/risoto.jpg")), filename: "risoto.jpg")

# rie
icon_riz = Icon.create(name: 'riz')
icon_riz.image.attach(io: File.open(Rails.root.join("app/assets/images/phonetic/riz.jpg")), filename: "riz.jpg")
icon_rie = Icon.create(name: 'rie')
icon_rie.image.attach(io: File.open(Rails.root.join("app/assets/images/phonetic/rie.jpg")), filename: "rie.jpg")
phonetic_ri = Phonetic.create(phonetic: 'ri')
phonetic_ri.direct_phonetic_icons = [icon_riz, icon_rie]
phonetic_ri.undirect_phonetic_icons = [icon_risoto]
syllable_ri = SyllableLetter.create(syllable_letter: 'ri', phonetic: phonetic_ri)
syllable_riz = SyllableLetter.create(syllable_letter: 'riz', phonetic: phonetic_ri)
syllable_rie = SyllableLetter.create(syllable_letter: 'rie', phonetic: phonetic_ri)

# so
icon_so = Icon.create(name: 'zoo')
icon_so.image.attach(io: File.open(Rails.root.join("app/assets/images/phonetic/zoo.webp")), filename: "zoo.webp")
phonetic_so = Phonetic.create(phonetic: 'so')
phonetic_so.direct_phonetic_icons = [icon_so]
syllable_so = SyllableLetter.create(syllable_letter: 'so', phonetic: phonetic_so)
syllable_zoo = SyllableLetter.create(syllable_letter: 'zoo', phonetic: phonetic_so)
syllable_zoo = SyllableLetter.create(syllable_letter: 'sau', phonetic: phonetic_so)
syllable_zoo = SyllableLetter.create(syllable_letter: 'seau', phonetic: phonetic_so)


# Creating some user of our application
tester = User.create(username: "tester", password: "123456")
user = User.create(username: "perceval", password: "123456")
user2 = User.create(username: "gluburuk", password: "123456")
user3 = User.create(username: "ayoub", password: "123456")

# Creating a simple response
rebus = RebusReponse.create(word: "bateau", difficulty: 10)
