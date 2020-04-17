# frozen_string_literal: true

Decidim.configure do |config|
  config.application_name = 'Decidim I2CAT APP'

  config.mailer_sender = 'decidim@decideix.com'

  # Change these lines to set your preferred locales
  config.default_locale = :ca
  config.available_locales = %i[ca en es]

  config.enable_html_header_snippets = true
  config.track_newsletter_links = true
  config.geocoder = {
    static_map_url: 'https://image.maps.cit.api.here.com/mia/1.6/mapview',
    here_app_id: Rails.application.secrets.geocoder[:here_app_id],
    here_app_code: Rails.application.secrets.geocoder[:here_app_code]
  }
end

Rails.application.config.i18n.available_locales = Decidim.available_locales
Rails.application.config.i18n.default_locale = Decidim.default_locale

Rails.application.config.to_prepare do
  Decidim::MenuRegistry.find(:menu).configurations.clear
  Decidim.menu :menu do |menu|
    menu.item I18n.t("menu.home", scope: "decidim"),
                    decidim.root_path,
                    position: 1,
                    active: :exclusive

    menu.item I18n.t("menu.help", scope: "decidim"),
              # decidim.pages_path,
              '/pages/faq',
              position: 2,
              active: :inclusive

    menu.item I18n.t("menu.processes", scope: "decidim"),
              # decidim_participatory_processes.participatory_processes_path,
              '/processes/solucions-hackovid/f/86/',
              position: 3,
              if: Decidim::ParticipatoryProcess.where(organization: current_organization).published.any?,
              active: %r{^\/process(es|_groups)}

    menu.item I18n.t('menu.solutions', scope: 'solutions'),
              '/solutions',
              position: 4,
              active: :inclusive

    menu.item I18n.t('menu.winners', scope: 'solutions'),
              '/winners',
              position: 5,
              active: :inclusive
  end

  # make decorators available
  Dir.glob(Rails.application.root + 'app/decorators/**/*_decorator.rb').each do |c|
    require_dependency(c)
  end
end
