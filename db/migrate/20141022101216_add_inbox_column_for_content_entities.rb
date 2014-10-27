class AddInboxColumnForContentEntities < ActiveRecord::Migration
  def change
    add_column :content_entities, :inbox, :boolean, default: true
  end
end
