class CreateParticipants < ActiveRecord::Migration
  def change
    create_table :participants do |t|
      t.integer :group_id
      t.integer :user_id

      t.timestamps
    end
    add_index :participants, :group_id
    add_index :participants, :user_id
  end
end
