vibbles_sources = [
  'main.vala',
]

vibbles_deps = [
  dependency('gio-2.0', version: '>= 2.50'),
  dependency('gtk+-3.0', version: '>= 3.22'),
]

gnome = import('gnome')

vibbles_sources += gnome.compile_resources('vibbles-resources',
  'vibbles.gresource.xml',
  c_name: 'vibbles'
)

executable('vibbles', vibbles_sources,
  vala_args: '--target-glib=2.50',
  dependencies: vibbles_deps,
  install: true,
)
