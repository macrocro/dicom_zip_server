class AddFilePathToExaminations < ActiveRecord::Migration
  def change
    add_column :examinations, :file_path, :string, :after => :exposure
  end
end
