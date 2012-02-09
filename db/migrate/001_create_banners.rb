class CreateBanners < ActiveRecord::Migration
  def self.up
    create_table :banners do |t|
      t.column :title, :string
      t.column :image, :string
      t.column :created_at, :datetime
      t.column :edited_at, :datetime
      t.timestamps
    end
  end

  def self.down
    drop_table :banners
  end
end
