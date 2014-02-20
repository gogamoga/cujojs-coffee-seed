do (curl = curl) ->
  config =
    baseUrl: ''

    paths: {} # Define paths here

    packages: [

      # Define application-level packages
      name: 'welcome'
      location: 'app/welcome'

    ,
      # Define a theme package, and configure it to always use the
      # css module loader. No need to use AMD 'css!' plugin to load things
      # in this package, it will happen automatically.
      # WARNING: The moduleLoader config syntax will be changing in an upcoming
      # version of curl.

      name: 'theme'
      location: 'theme'
      config: moduleLoader: 'curl/plugin/css'
    ,
      # Add third-party packages here
       name: 'curl', location: 'bower_components/curl/src/curl'
    ,
       name: 'wire', location: 'bower_components/wire', main: 'wire'
    ,
       name: 'cola', location: 'bower_components/cola', main: 'cola'
    ,
       name: 'rest', location: 'bower_components/rest', main: 'rest'
    ,
       name: 'msgs', location: 'bower_components/msgs', main: 'msgs'
    ,
       name: 'when', location: 'bower_components/when', main: 'when'
    ,
       name: 'meld', location: 'bower_components/meld', main: 'meld'
    ,
       name: 'poly', location: 'bower_components/poly'

    ]

    # Turn off i18n locale sniffing. Change or remove this line if you want
    # to test specific locales or try automatic locale-sniffing.
    locale: false,

    # Polyfill everything ES5-ish
    preloads: ['poly/all']

    # Or, select individual polyfills if you prefer

    #preloads: do ->
    #  for fill in ['function', 'json', 'object', 'string', 'xhr']
    #    "poly/#{fill}"


  (curl config, ['wire!app/main']).then success, failure

  # Success! curl.js indicates that your app loaded successfully!
  success = ->
    # When using wire, the success callback is typically not needed since
    # wire will compose and initialize the app from the main spec.
    # However, this callback can be useful for executing startup tasks
    # you don't want inside of a wire spec, such as this:

    console.log "Looking good! 404 for bundle.js is ok - See README.md"

  # Failure!. curl.js indicates that your app failed to load correctly.
  failure = (ex) ->

    # There are many ways to handle errors. This is just a simple example.
    # Note: you cannot rely on any specific library or shim to be
    # loaded at this point.  Therefore, you must use standard DOM
    # manipulation and legacy IE equivalents.

    console.log "An error happened during loading :'(#{ex.message})'"
    console.log ex.stack if ex.stack

    msg = "An error occured while loading: #{ex.message}. Check console."

    if el = document.getElementById "errout"
      # inject the error message
      if 'textContent' in el
        el.textContent = msg
      else
        el.innerText = msg

      # clear styling that may be hiding the error message
      el.style.display = ""
      document.documentElement.className = ""

    else
      throw msg
