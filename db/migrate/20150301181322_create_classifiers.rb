class CreateClassifiers < ActiveRecord::Migration
  def change
    create_table :classifiers do |t|

      t.timestamps
    end
  end
end
