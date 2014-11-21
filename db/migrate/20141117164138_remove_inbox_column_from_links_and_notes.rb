class RemoveInboxColumnFromLinksAndNotes < ActiveRecord::Migration
  def change
    remove_column :notes, :inbox, :boolean, default: true
    remove_column :links, :inbox, :boolean, default: true
  end
end
