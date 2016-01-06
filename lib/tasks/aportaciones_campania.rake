namespace :aportaciones_campania do
  task extraer: :environment do
    browser = Capybara.current_session
    url = 'https://www.web.onpe.gob.pe/servicios/financiamiento-organizaciones-politicas/aportes-limpios/'
    browser.visit url
  end
end
