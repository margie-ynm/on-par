class CreateScorecards < ActiveRecord::Migration[5.0]
  def change
    create_table :scorecards do |t|
      t.column :playdate, :date
      t.column :course_id, :integer

      t.timestamps()
    end
  end
end
