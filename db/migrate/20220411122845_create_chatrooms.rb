class CreateChatrooms < ActiveRecord::Migration[6.1]
  def change
    create_table :chatrooms do |t|
     # t.references :user, null: false, foreign_key: true
      t.references :sender, index: true, foreign_key: {to_table: :users}
      t.references :recepient, index: true, foreign_key: {to_table: :users}

      t.timestamps
    end
  end
end
