class AddQuestionViews < ActiveRecord::Migration[6.1]
  def change
    add_column :questions, :views, :integer, default: 0, null: false
  end
end
