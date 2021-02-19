class CreateEvents < ActiveRecord::Migration[6.1]
  def change
    create_table :events do |t|
      t.string :name, null: false
      t.date :due_date, null: false
      t.references :sport, null: false, foreign_key: true

      t.timestamps
    end

    add_index :events, :name, unique: true
  end
end

