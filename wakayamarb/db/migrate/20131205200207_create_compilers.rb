class CreateCompilers < ActiveRecord::Migration
  def change
    create_table :compilers do |t|
      t.string :rb
      t.string :options

      t.timestamps
    end
  end
end
