class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :username
      t.string :password_digest
      t.integer :points, :default => 0
      #Ex:- :default =>''
      t.timestamps
    end
    add_index :users, :username, unique: true
  end
end
