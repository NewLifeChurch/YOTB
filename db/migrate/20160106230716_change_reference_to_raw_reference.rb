class ChangeReferenceToRawReference < ActiveRecord::Migration
  def change
    rename_column :verses, :reference, :raw_reference
  end
end
