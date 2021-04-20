class CreateReplies < ActiveRecord::Migration[6.1]
  def change
    create_table :replies do |t|
      t.belongs_to :question
      t.text :body

      t.timestamps
    end
  end
end
