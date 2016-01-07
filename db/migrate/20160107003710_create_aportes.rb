class CreateAportes < ActiveRecord::Migration[5.0]
  def change
    create_table :aportes do |t|
      t.date :fecha
      t.string :proceso_electoral
      t.string :apellido_paterno
      t.string :apellido_materno
      t.string :nombre
      t.string :tipo_doc
      t.string :nrodoc
      t.string :tipo
      t.string :naturaleza
      t.decimal :importe
      t.timestamps
    end
  end
end
