class AddTagsColumns < ActiveRecord::Migration[6.1]
  def change
    add_column :shops, :tags,  :string, array: true
    add_column :reviews, :tags,  :string, array: true
  end
end
