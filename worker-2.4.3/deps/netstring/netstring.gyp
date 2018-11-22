{
  'targets':
  [
    {
      'target_name': 'netstring',
      'type': 'static_library',
      'sources':
      [
        'netstring-c/netstring.c'
      ],
      'direct_dependent_settings':
      {
        'include_dirs':
        [
          'netstring-c'
        ]
      },
      'conditions':
      [
        [ 'OS != "win"', {
          'cflags': [ '-Wall', '-fPIC' ]
        }],
        [ 'OS == "mac"', {
          'xcode_settings':
          {
            'WARNING_CFLAGS': [ '-Wall' ]
          }
        }]
      ]
    }
  ]
}
