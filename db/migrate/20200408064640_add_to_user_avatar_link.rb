class AddToUserAvatarLink < ActiveRecord::Migration[6.0]
  def change
     add_column :users, :avatar_link, :string
  end
end
