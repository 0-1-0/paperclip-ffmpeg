class AddMobileToVideo < ActiveRecord::Migration
  def change
    add_attachment :videos, :mobile
  end
end
