class CreateHoles < ActiveRecord::Migration[5.0]
  def change
    create_table :holes do |t|
      t.column :hole_num, :integer
      t.column :course_id, :integer
      t.column :par, :integer
      t.column :yards, :float

      t.timestamps()
    end
  end
end
