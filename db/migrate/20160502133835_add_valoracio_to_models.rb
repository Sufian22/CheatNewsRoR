class AddValoracioToModels < ActiveRecord::Migration
  def change
    add_column :submissions, :valoracio, :integer
    add_column :comments, :valoracio, :integer
    add_column :replies, :valoracio, :integer
  end
end
