class CreateCollections < ActiveRecord::Migration
  def change
    create_table :collections do |t|
      t.string   :slug,           :null => false

      t.timestamps
    end
  end
end
