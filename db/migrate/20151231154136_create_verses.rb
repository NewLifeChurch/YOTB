class CreateVerses < ActiveRecord::Migration
  def change
    create_table :verses do |t|
      t.integer :devo_id
      t.string :reference

      t.timestamps null: false
    end
  end
end
