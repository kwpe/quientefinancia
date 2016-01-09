class Aporte < ApplicationRecord
  belongs_to :aporte_periodo

  def nombre_completo
    "#{nombre} #{apellido_paterno} #{apellido_materno}"
  end

  def campos_importantes
    slice(:tipo_doc, :nro_doc).merge(importe: importe.to_i)
  end
end
