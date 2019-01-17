class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|

		t.string :head
		t.string :body
		
		#does not reference tags, because it's a one-to-many relationship. one task has many tags.

		t.timestamps
    end
  end
end
