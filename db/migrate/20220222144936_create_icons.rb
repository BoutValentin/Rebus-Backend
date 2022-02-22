class CreateIcons < ActiveRecord::Migration[7.0]
  def change
    create_table :icons do |t|
      t.string :name

      t.timestamps
    end
  end
end
