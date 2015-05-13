class CreateSentencesTable < ActiveRecord::Migration
  def change
    create_table :sentences do |t|
      t.string :content
      t.string :verbs, array: true, default: []
      t.string :adjectives, array: true, default: []
    end
  end
end
