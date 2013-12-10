class AddColumnToExamination < ActiveRecord::Migration
  def change
    add_column :examinations, :series_description, :string, :after => :series_instance_uid
  end
end
