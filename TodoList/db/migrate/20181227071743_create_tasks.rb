class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|

		t.string :head
		t.string :body
		
		#does not reference tag; mapping between task and tag is done by tagging

		t.timestamps
    end
  end
end
