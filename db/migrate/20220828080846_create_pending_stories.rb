class CreatePendingStories < ActiveRecord::Migration[7.0]
  def change
    create_table :pending_stories do |t|
      t.references :stories, null: false, foreign_key: true

      t.timestamps
    end
  end
end
