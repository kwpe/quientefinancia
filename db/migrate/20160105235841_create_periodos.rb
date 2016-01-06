class CreatePeriodos < ActiveRecord::Migration[5.0]
  def change
    create_table :periodos do |t|
      t.string :descripcion
      t.decimal :aporte_efectivo
      t.decimal :aporte_especies
      t.decimal :total

      t.timestamps
    end
  end
end
