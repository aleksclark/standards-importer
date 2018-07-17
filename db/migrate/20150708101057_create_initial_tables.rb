class CreateInitialTables < ActiveRecord::Migration[4.2]
  def change
    create_table :jurisdictions do |t|
      t.column :csp_id, :string
      t.column :document, :json
      t.string :title
      t.string :type
    end

    add_index :jurisdictions, :csp_id

    create_table :standards do |t|
      t.column :jurisdiction_id, :integer, null: false
      t.column :csp_id, :string
      t.column :parent_ids, :integer, array: true, null: false, default: []
      t.column :education_levels, :string, array: true, null: false, default: []
      t.string :title
      t.string :subject
      t.column :document, :json
      t.column :indexed, :boolean, null:false, default: false
      t.column :child_count, :integer, default: 0
      t.foreign_key :jurisdictions
    end

    add_index :standards, :jurisdiction_id
    add_index :standards, :csp_id
    add_index :standards, :parent_ids, using: 'gin'

  end
end
