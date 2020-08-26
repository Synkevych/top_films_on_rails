class RemoveCommenterFromComments < ActiveRecord::Migration[6.0]
  def change

    remove_column :comments, :commenter, :text
  end
end
