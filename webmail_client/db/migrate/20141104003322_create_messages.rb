class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :subject
      t.string :body
      t.belongs_to :sender
      t.belongs_to :receiver

      t.timestamps
    end
  end
end
