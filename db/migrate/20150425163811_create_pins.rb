class CreatePins < ActiveRecord::Migration
  def change
    create_table :pins do |t|
      t.references :user, index: true, foreign_key: true
      t.references :idea, index: true, foreign_key: true
      t.integer :postion

      t.timestamps null: false
    end
  end
end
