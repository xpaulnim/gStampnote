conf_data = configuration_data()
conf_data.set('PROJECT_NAME', meson.project_name())
conf_data.set('RELEASE_NAME', 'gStampnote')

config_header = configure_file(
    input: 'config.vala.in',
    output: 'config.vala',
    configuration: conf_data
)

gstampnote_sources = [
    'Application.vala',
    'Window.vala',
    'Controller.vala',
    'Models/Note.vala',
    'Models/Summary.vala',
    'Services/CsvSerDe.vala',
    'Widgets/HeaderBar.vala',
    'Widgets/SideBar.vala',
    'Widgets/Content.vala',
    config_header,
    gstampnote_resources
]

gstampnote_deps = [
  dependency('gio-2.0', version: '>= 2.50'),
  dependency('gtk+-3.0', version: '>= 3.22'),
  dependency('gee-0.8')
]

executable('gstampnote', gstampnote_sources,
  vala_args: '--target-glib=2.50',  dependencies: gstampnote_deps,
  install: true,
)	
