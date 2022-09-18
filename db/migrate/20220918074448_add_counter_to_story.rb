class AddCounterToStory < ActiveRecord::Migration[7.0]
  def change
    add_column :stories, :love, :integer, default: 0
  end
end
