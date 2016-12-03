class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members do |t|
      t.string :first_name
      t.string :last_name
      t.date :dob
      t.string :street
      t.integer :house_number
      t.integer :zip
      t.string :mobile_phone
      t.string :email
      t.string :gender
      t.integer :employed
      t.string :activiti_type
      t.integer :status
      t.string :academic_qualification
      t.string :qualifications

      t.timestamps null: false
    end
  end
end
