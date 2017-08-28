class CreateLogs < ActiveRecord::Migration
  def change
    create_table :logs do |t|
      t.string :date
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
