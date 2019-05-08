class CreateDocuments < ActiveRecord::Migration[5.2]
  def change
    create_table :documents do |t|
      t.string :title
      t.text :content
      t.string :uuid
      t.references :user
      t.timestamps
    end
  end
end
