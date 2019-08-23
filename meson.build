project('gstampnote', ['c', 'vala'],
        version: '0.1.0',
  meson_version: '>= 0.40.0',
)

i18n = import('i18n')

gnome = import('gnome')
gstampnote_resources = gnome.compile_resources(
	'gstampnote-resources', 'data/gstampnote.gresource.xml',
	source_dir: 'data',
  	c_name: 'gstampnote'
)

subdir('data')
subdir('src')
subdir('po')

meson.add_install_script('build-aux/meson/postinstall.py')
