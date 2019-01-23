class CreateTags < ActiveRecord::Migration[5.2]
  def change
    create_table :tags do |t|

	  t.string :name
	  
	  #doesn't reference task - mapping between tags and tasks is done by tagging

      t.timestamps
    end
  end
end
