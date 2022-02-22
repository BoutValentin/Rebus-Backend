class AddUniqueIndexToIconPhonetics < ActiveRecord::Migration[7.0]
  def change
    add_index :icon_phonetics, [:icon_id, :direct_phonetic_id], unique: true
    add_index :icon_phonetics, [:icon_id, :undirect_phonetic_id], unique: true
  end
end
