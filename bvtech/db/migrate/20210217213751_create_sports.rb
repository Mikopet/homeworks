class CreateSports < ActiveRecord::Migration[6.1]
  def change
    create_table :sports do |t|
      t.integer :external_id
      t.string :name
      t.boolean :active, default: true

      t.timestamps
    end

    add_index :sports, :external_id, unique: true
    add_index :sports, [:name, :external_id], unique: true
  end
end
