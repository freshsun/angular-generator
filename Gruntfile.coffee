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
        dest:'build/'
        ext:'.js'
      buildtest:
        expand:true
        cwd:'test/src'
        src:'**/*.coffee'
        dest:'test/'
        ext:'.js'

    jade:
      options:
        pretty:true
      build:
        expand:true
        cwd:'src/'
        src:'**/*.jade'
        dest:'build/'
        ext:'.html'

    compass:
      build:
        options:
          sassDir:'src/styles'
          cssDir:'build/styles'


    watch:
      files:
        expand:true
        files:['src/**/**','!**/*.jade','!**/*.coffee','!**/*.sass']
        tasks:['newer:copy']
      html:
        files:['src/**/*.jade']
        tasks:['newer:jade']
        options:
          livereload:true
      js:
        files:['src/**/*.coffee','test/**/*.coffee']
        tasks:['newer:coffee']
        options:
          livereload:true
      css:
        files:['src/**/*.sass']
        tasks:['compass']
        options:
          livereload:true

    copy:
      build:
        expand:true
        cwd:'src/'
        src:'**/*.{json,svg,png,gif,jpg,ttf,html,js,css}'
        dest:'build/'
      dist:
        expand:true
        cwd:'build/'
        src:'**/*.{json,svg,png,gif,jpg,ttf,html,js,css}'
        dest:'dist/'

    clean:
      build:
        src:['build/**/*']
      dist:
        src:['dist/**/*']
      test:
        src:['test/e2e/**/*.js','test/unit/**/*.js']

    bower:
      install:
        options:
          targetDir:'./src/lib'
          cleanTargetDir:true

    karma:
      unit:
        configFile:'test/karma.conf.js'
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
          base:'build'
          keepalive:true
          livereload:true


  grunt.registerTask 'builddev', ['newer:jade:build','newer:coffee:build','compass:build', 'newer:copy:build']
  grunt.registerTask 'cleandev', ['clean:build','clean:dist']
  grunt.registerTask 'unit', ['karma']
  grunt.registerTask 'buildtest', ['newer:coffee:buildtest']
  grunt.registerTask 'cleantest', ['clean:test']
  ###
  available tasks watch,karma
###
