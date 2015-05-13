class CreateModifiedsentences < ActiveRecord::Migration
  def change
    create_table :modifiedsentences do |t|
      t.string :content
      t.timestamps null: false
    end
  end
end
