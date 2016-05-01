class CreateSubmissions < ActiveRecord::Migration
  def change
    create_table :submissions do |t|
      t.string :title
      t.string :link
      t.text :description
      t.integer :tipo
      t.integer :user_id
      t.references :user, index: true, foreign_key: true
      t.timestamps null: false
    end
  end
end
