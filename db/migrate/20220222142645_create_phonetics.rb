class CreatePhonetics < ActiveRecord::Migration[7.0]
  def change
    create_table :phonetics do |t|
      t.string :phonetic

      t.timestamps
    end
  end
end
