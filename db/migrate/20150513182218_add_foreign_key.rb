class AddForeignKey < ActiveRecord::Migration
  def change
    add_column :modifiedsentences, :sentence_id, :integer
  end
end
