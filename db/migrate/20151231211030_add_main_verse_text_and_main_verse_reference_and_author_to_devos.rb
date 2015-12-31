class AddMainVerseTextAndMainVerseReferenceAndAuthorToDevos < ActiveRecord::Migration
  def change
    add_column :devos, :main_verse_text, :string
    add_column :devos, :main_verse_reference, :string
    add_column :devos, :author, :string
  end
end
