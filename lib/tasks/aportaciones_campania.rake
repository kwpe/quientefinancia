namespace :aportaciones_campania do
  task extraer: :environment do
    include Capybara::DSL
    url = 'https://www.web.onpe.gob.pe/servicios/financiamiento-organizaciones-politicas/aportes-limpios/'
    visit url
    find('#cboTipo').select('PARTIDO POLITICO')
    find('#cboOrga').select('TODOS POR EL PERÚ')
    click_on('BUSCAR')
    within('#accordion') do
      find("[href='#collapse0']").click()
      within('table tbody') do
        all('tr').each do |tr|
          celdas = tr.all('td')
          unless celdas[0].text.strip == 'TOTAL'
            Periodo.create(
              descripcion: celdas[0].text.strip,
              aporte_efectivo: celdas[1].text.strip,
              aporte_especies: celdas[2].text.strip,
              total: celdas[3].text.strip
            )
          end
        end
      end
    end
  end
end
