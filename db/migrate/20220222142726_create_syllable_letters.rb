class CreateSyllableLetters < ActiveRecord::Migration[7.0]
  def change
    create_table :syllable_letters do |t|
      t.string :syllable_letter
      t.references :phonetic, null: true, foreign_key: true

      t.timestamps
    end
  end
end
