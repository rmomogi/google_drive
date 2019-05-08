class CreatePermissions < ActiveRecord::Migration[5.2]
  def change
    create_table :permissions do |t|
    	t.references :user, index: true, foreign_key: true
    	t.boolean :accept, default: false
    	t.string :uuid
      t.timestamps
    end
  end
end
