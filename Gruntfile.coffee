module.exports = (grunt) ->
  (require 'load-grunt-tasks') grunt
  grunt.initConfig
    pkg:grunt.file.readJSON('package.json')

    coffee:
      options:
        bare:true
      build:
        expand:true
        cwd:'src'
        src:'**/*.coffee'
        dest:'www/'
        ext:'.js'

    jade:
      options:
        pretty:true
        doctype:'html'
      build:
        expand:true
        cwd:'src/'
        src:'**/*.jade'
        dest:'www/'
        ext:'.html'

    compass:
      build:
        options:
          sassDir:'src'
          cssDir:'www'


    watch:
      files:
        expand:true
        files:['src/**/**','!**/*.jade','!**/*.coffee','!**/*.sass']
        tasks:['newer:copy']
      jstemplate:
        files:['src/app/components/**/*.jade']
        tasks:['newer:jade','ngtemplates']
      inithtml:
        files:['src/index.jade']
        tasks:['newer:jade', 'sails-linker']
        options:
          livereload:true
      js:
        files:['src/**/*.coffee']
        tasks:['newer:coffee']
      css:
        files:['src/**/*.sass']
        tasks:['compass']
      jscssindex:
        files:['www/**/*.js', 'www/**/*.css']
        tasks:['sails-linker']
        options:
          livereload:true

    copy:
      build:
        expand:true
        cwd:'src/'
        src:['**/*.{json,svg,png,gif,jpg,ttf,html,js,css}']
        dest:'www/'
      dist:
        expand:true
        cwd:'www/'
        src:['**/*.{json,svg,png,gif,jpg,ttf,html,js,css}']
        dest:'dist/'

    clean:
      build:
        src:['www/**/*']
      dist:
        src:['dist/**/*']

    wiredep:
      target:
        src:['src/index.jade']
        cwd: ''
        dependencies: true
        devDependencies: false
        exclude: []
        fileTypes: {}
        ignorePath: 'src/'

    karma:
      unit:
        configFile:'karma.conf.js'
        autorun:true

#    protractor:
#      options:
#        #configFile: 'npm_modules/protractor/examples/conf.js'
#        keepAlive: true
#        noColor: false
#        verbose:true
#        debug: true
#        args:
#          specs:['test/e2e/**/*.js']

    connect:
      server:
        options:
          port:8000
          hostname:'0.0.0.0'
          base:'www'
          keepalive:true
          livereload:true

    'sails-linker':
      js:
        options:
          startTag: '<!--start scripts-->'
          endTag: '<!--end scripts-->'
          fileTmpl: '<script src="%s"></script>'
          appRoot: 'www/'
##TODO clarify the js dependencies
        files:
          'www/index.html': ['www/app/assets/**/*.js', 'www/app/**/*.js','www/app/components/**/*.js']
      css:
        options:
          startTag: '<!--start css-->'
          endTag: '<!--end css-->'
          fileTmpl: '<link rel="stylesheet" href="%s"/>'
          appRoot: 'www/'
        files:
          'www/index.html': [ 'www/app/**/*.css']

    ngtemplates:
      app:
        cwd:      'www/app'
        src:      'components/**/*.html'
        dest:     'www/app/templates.js'

  grunt.registerTask 'build', ['wiredep', 'newer:jade:build','newer:coffee:build','compass:build', 'newer:copy:build', 'ngtemplates','sails-linker']
  grunt.registerTask 'unit', ['karma']
