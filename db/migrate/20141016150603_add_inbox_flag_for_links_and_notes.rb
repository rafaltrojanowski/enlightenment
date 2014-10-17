class AddInboxFlagForLinksAndNotes < ActiveRecord::Migration
  def change
    add_column :notes, :inbox, :boolean, default: true
    add_column :links, :inbox, :boolean, default: true
  end
end
