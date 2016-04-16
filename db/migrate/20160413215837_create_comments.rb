class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :texto
      t.integer :user_id
      t.integer :submission_id

      t.timestamps null: false
    end
  end
end
