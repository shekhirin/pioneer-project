class AddMissingConstraints < ActiveRecord::Migration[6.1]
  def change
    change_column_null :questions, :body, false
    change_column_null :tags, :name, false
  end
end
