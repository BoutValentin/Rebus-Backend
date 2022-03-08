class CreateRebusReponses < ActiveRecord::Migration[7.0]
  def change
    create_table :rebus_reponses do |t|
      t.string :word
      t.integer :difficulty

      t.timestamps
    end
  end
end
