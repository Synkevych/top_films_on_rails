# This file create automatically 
# Those attributes are automatically added to the articles table 
# and mapped to the Article model 

# This file is responsible for creating the database structure, which us what we'll look at next

class CreateArticles < ActiveRecord::Migration[6.0]
  def change
    create_table :articles do |t|
      t.string :title
      t.text :text
      
      t.timestamps
    end
  end
end
