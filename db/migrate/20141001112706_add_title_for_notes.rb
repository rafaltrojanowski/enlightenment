class AddTitleForNotes < ActiveRecord::Migration
  def change
    add_column :notes, :title, :string
  end
end
