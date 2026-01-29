class RenameEmailToEmailAddressInUsers < ActiveRecord::Migration[7.0]
  def change
    rename_column :users, :email, :email_address
  end
end
