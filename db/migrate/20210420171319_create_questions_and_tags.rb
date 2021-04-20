class CreateQuestionsAndTags < ActiveRecord::Migration[6.1]
  def change
    create_table :tags do |t|
      t.string :name

      t.timestamps
    end

    create_table :questions do |t|
      t.text :body

      t.timestamps
    end

    create_table :question_tags do |t|
      t.belongs_to :question
      t.belongs_to :tag

      t.timestamps
    end
  end
end
