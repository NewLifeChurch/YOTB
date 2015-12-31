class CreateDevos < ActiveRecord::Migration
  def change
    create_table :devos do |t|
      t.integer :day
      t.date :date
      t.text :text

      t.timestamps null: false
    end
  end
end
