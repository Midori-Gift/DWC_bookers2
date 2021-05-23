class ChangeColumnToAllowNull < ActiveRecord::Migration[5.2]
  def up
    change_column :books, :title,:string, null: true
    change_column :books, :body, :text, null: true
  end

  def down
    change_column :books, :title,:text, null: false
    change_column :books, :body, :text, null: false

  end

end
