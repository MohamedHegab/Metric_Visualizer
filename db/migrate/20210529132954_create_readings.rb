class CreateReadings < ActiveRecord::Migration[6.1]
  def change
    create_table :readings do |t|
      t.datetime :time
      t.integer :value
      t.belongs_to :metric, null: false, index: true, foreign_key: true

      t.timestamps default: -> { 'CURRENT_TIMESTAMP' }
    end
    add_index :readings, [:time, :value]
  end
end
