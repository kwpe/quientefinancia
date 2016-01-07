class CreateAportePeriodos < ActiveRecord::Migration[5.0]
  def change
    create_table :aportes_periodo do |t|
      t.string :nombre
      t.string :tipo_doc
      t.string :nrodoc
      t.decimal :importe
      t.belongs_to :periodo

      t.timestamps
    end
  end
end
