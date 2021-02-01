class RemoveMetricTypeFromMetrics < ActiveRecord::Migration[6.0]
  def up
    remove_reference :metrics, :metric_type
    drop_table :metric_types

    add_column :metrics, :metric_type_id, :smallint, null: false, index: true
  end

  def down
    fail ActiveRecord::IrreversibleMigration
  end
end
