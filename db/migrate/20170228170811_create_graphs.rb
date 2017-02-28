class CreateGraphs < ActiveRecord::Migration[5.0]
  def change
    create_table :graphs do |t|
      t.references :user, foreign_key: true
      t.string :name
      t.string :description
      t.integer :type
      t.string :tag

      t.timestamps
    end
  end
end
