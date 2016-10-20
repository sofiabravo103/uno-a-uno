class CreateSingletonInfo < ActiveRecord::Migration[5.0]
  def change
    create_table :singleton_infos do |t|
      t.text :info_send
      t.text :info_recv
      t.text :info_p
    end
  end
end
