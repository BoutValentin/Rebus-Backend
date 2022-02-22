class CreateIconPhonetics < ActiveRecord::Migration[7.0]
  def change
    create_table :icon_phonetics do |t|
      t.references :icon, null: false, foreign_key: true
      t.references :direct_phonetic, references: :phonetics, null: true, foreign_key: { to_table: :phonetics }
      t.references :undirect_phonetic, references: :phonetics, null: true, foreign_key: { to_table: :phonetics }
      t.timestamps
    end
  end
end
