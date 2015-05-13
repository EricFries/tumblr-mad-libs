class CreateSentencesTable < ActiveRecord::Migration
  def change
    create_table :sentences do |t|
      t.string :content
      t.string :verbs
      t.string :adjectives
    end
  end
end
