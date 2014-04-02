class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :request_ip
      t.datetime :expiration
      t.string :token
      t.timestamps
    end
  end
end
