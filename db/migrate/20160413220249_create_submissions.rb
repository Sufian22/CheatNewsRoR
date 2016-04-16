class CreateSubmissions < ActiveRecord::Migration
  def change
    create_table :submissions do |t|
      t.string :link
      t.text :description
      t.integer :tipo
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
