class CreateExaminations < ActiveRecord::Migration
  def change
    create_table :examinations do |t|
      t.string :study
      t.string :name
      t.string :voltage
      t.string :current
      t.string :exposure

      t.timestamps
    end
  end
end
