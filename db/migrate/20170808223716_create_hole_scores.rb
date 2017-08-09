class CreateHoleScores < ActiveRecord::Migration[5.0]
  def change
    create_table :hole_scores do |t|
      t.column :hole_num, :integer
      t.column :scorecard_id, :integer

      t.column :number_of_putts, :integer
      t.column :score, :integer
      t.column :fairway, :boolean, default: false
      t.column :green_ir, :boolean, default: false

      t.timestamps()
    end
  end
end
