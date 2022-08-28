class RenameReference < ActiveRecord::Migration[7.0]
  def change
    remove_reference :pending_stories, :stories, index: true, foreign_key: true
    add_reference :pending_stories, :story, index: true, foreign_key: true
  end
end
