class CreateMarkets < ActiveRecord::Migration[6.1]
  def change
    create_table :markets do |t|
      t.string :name, null: false
      t.references :sport, null: false, foreign_key: true

      t.timestamps
    end

    add_index :markets, :name, unique: true
  end
end

