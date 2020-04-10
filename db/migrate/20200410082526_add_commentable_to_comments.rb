class AddCommentableToComments < ActiveRecord::Migration[6.0]
  # перед выполнением миграции удалить все коментарии из базы
  def change
    add_reference :comments, :commentable, polymorphic: true, null: false
  end
end
