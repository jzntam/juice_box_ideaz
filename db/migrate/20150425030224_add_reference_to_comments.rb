class AddReferenceToComments < ActiveRecord::Migration
  def change
    add_reference :comments, :idea, index: true, foreign_key: true
  end
end
