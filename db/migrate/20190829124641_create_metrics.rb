class CreateMetrics < ActiveRecord::Migration[6.0]
  def change
    create_table :metrics do |t|
      t.datetime :timestamp
      t.integer :customer_id
      t.integer :admin_id
      t.references :metric_type, null: false, foreign_key: true
    end
  end
end
