class AddAvatarToContributors < ActiveRecord::Migration
  def change
    add_column :contributors, :avatar, :string
  end
end
