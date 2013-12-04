module.exports = (grunt) ->

	grunt.initConfig(
		pkg: grunt.file.readJSON('package.json')

		coffee:
			options:
				bare: true
			compile:
				files:
					'jsonp.js': 'jsonp.coffee'

		uglify:
			options:
				banner: '/* Jsonp <%= pkg.version %> */'
			js:
				files:
					'jsonp.min.js': 'jsonp.js'
	)


	grunt.loadNpmTasks('grunt-contrib-coffee')
	grunt.loadNpmTasks('grunt-contrib-uglify')

	grunt.registerTask('default', ['coffee:compile', 'uglify:js'])