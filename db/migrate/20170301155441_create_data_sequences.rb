class CreateDataSequences < ActiveRecord::Migration[5.0]
  def change
    create_table :data_sequences do |t|
      t.references :graph, foreign_key: true
      t.string :meta
      t.string :data

      t.timestamps
    end
  end
end
