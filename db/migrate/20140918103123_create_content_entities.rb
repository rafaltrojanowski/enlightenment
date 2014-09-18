class CreateContentEntities < ActiveRecord::Migration
  def change
    create_table :content_entities do |t|
      t.integer :user_id
      t.integer :group_id
      t.integer :contentable_id
      t.string :contentable_type

      t.timestamps
    end
  end
end
