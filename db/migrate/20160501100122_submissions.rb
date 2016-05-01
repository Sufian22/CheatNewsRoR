class Submissions < ActiveRecord::Migration
  def change
    add_column :title, :string 
  end
end
