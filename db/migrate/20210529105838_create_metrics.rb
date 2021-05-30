class CreateMetrics < ActiveRecord::Migration[6.1]
  def change
    create_table :metrics do |t|
      t.string :name

      t.timestamps
    end
    add_index :metrics, :name
  end
end
