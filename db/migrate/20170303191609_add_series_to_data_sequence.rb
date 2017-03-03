class AddSeriesToDataSequence < ActiveRecord::Migration[5.0]
  def change
    add_column :data_sequences, :series, :integer, default: 0
  end
end
