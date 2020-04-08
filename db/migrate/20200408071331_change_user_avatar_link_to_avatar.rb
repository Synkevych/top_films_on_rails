class ChangeUserAvatarLinkToAvatar < ActiveRecord::Migration[6.0]
  def change
     rename_column :users, :avatar_link, :avatar
  end
end
