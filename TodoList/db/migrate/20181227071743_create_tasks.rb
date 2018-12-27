class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|

		t.string :head
		t.string :body
		#references also

		t.timestamps
    end
  end
end
