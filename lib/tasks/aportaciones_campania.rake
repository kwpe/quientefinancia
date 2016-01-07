namespace :aportaciones_campania do
  URL = 'https://www.web.onpe.gob.pe/servicios/financiamiento-organizaciones-politicas/aportes-limpios/'

  task extraer: :environment do
    include Capybara::DSL
    carga_partido 'TODOS POR EL PERÚ'
    within('#accordion') do
      find("[href='#collapse0']").click
      tabla_periodos = find('table tbody')
      guarda_todos_los_periodos(tabla_periodos)
    end
    Periodo.all.each_with_index do |periodo, i|
      all('#accordion table tbody tr')[i].all('td')[3].click
      tabla_aportes = find('#detAll table tbody')
      guarda_todos_los_aportes(tabla_aportes, periodo)
      click_on 'REGRESAR'
    end
  end

  def guarda_periodo(celdas)
    Periodo.create(
      descripcion: celdas[0].text.strip,
      aporte_efectivo: celdas[1].text.strip,
      aporte_especies: celdas[2].text.strip,
      total: celdas[3].text.strip
    )
  end

  def guarda_todos_los_periodos(tabla)
    tabla.all('tr').each do |tr|
      celdas = tr.all('td')
      guarda_periodo(celdas) unless celdas[0].text.strip == 'TOTAL'
    end
  end

  def guarda_todos_los_aportes(tabla, periodo)
    aportes = []
    aportes_del_periodo = []
    tabla.all('tr').each_cons(2) do |tr_actual, tr_sgte|
      celdas_actual = tr_actual.all('td')
      aportes << nuevo_aporte(celdas_actual)
      celdas_sgte = tr_sgte.all('td')
      if celdas_sgte[0].text.strip == 'TOTAL APORTADO'
        aporte_periodo = nuevo_aporte_del_periodo(aportes.first, total: celdas_sgte[1].text.strip)
        aporte_periodo.aportes << aportes
        aportes_del_periodo << aporte_periodo
      end
    end
    periodo.aportes_por_periodo << aportes_del_periodo
    periodo.save
  end

  def nuevo_aporte_del_periodo(aporte, total:)
    AportePeriodo.new(
      nombre: aporte.nombre,
      tipo_doc: aporte.tipo_doc,
      nrodoc: aporte.nrodoc,
      importe: total,
      periodo_id: aporte.periodo_id
    )
  end

  def nuevo_aporte(celdas)
    Aporte.new(
      fecha: celdas[0].text.strip,
      proceso_electoral: celdas[1].text.strip,
      apellido_paterno: celdas[2].text.strip,
      apellido_materno: celdas[3].text.strip,
      nombre: celdas[4].text.strip,
      tipo_doc: celdas[5].text.strip,
      nrodoc: celdas[7].text.strip,
      tipo: celdas[8].text.strip,
      naturaleza: celdas[9].text.strip,
      importe: celdas[10].text.strip,
    )
  end

  def carga_partido(partido)
    visit URL
    find('#cboTipo').select('PARTIDO POLITICO')
    find('#cboOrga').select(partido)
    click_on('BUSCAR')
  end
end
