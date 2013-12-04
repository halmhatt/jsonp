# A class which is able to make jsonp requests
class Jsonp

	PARENT = document.head ? document.getElementsByTagName('head')[0]

	# Append to the head
	@append = (element) ->

		PARENT.appendChild(element)

	# Create a script element
	@element = (src)->
		el = document.createElement('script')
		el.src = src
		el.innerText = "/* JSONP callback element initialized: #{new Date().toString()} */"

		# Remove element on load
		el.onload = ->
			el.remove()

		return el

	# Create a query string from object
	@query: (queryObj = {}) ->

		# Check if it is a string
		if typeof queryObj is 'string'
			return queryObj

		params = []

		for own key, val of queryObj
			params.push("#{key}=#{val}")

		return params.join('&')

	# Create a random hash used for callbacks
	hash = ->
		hash = ''

		while hash.length < 12
			hash += Math.floor(10+Math.random()*26).toString(36)

		return hash

	# Get is the only possible method when using jsonp
	@get: (options = {}) ->

		# Get url
		url = options.url ? throw 'You need to provide an url'

		# Provide data if it does not exist
		data = options.data ? {}

		# Should the response be cached?
		if options.cache isnt true
			data.timestamp = new Date().getTime()

		# If success callback is provided
		if options.success?

			# Attach callback to window object
			callbackName = options.jsonp_callback ? 'callback_'+hash()
			
			# Add callback to data
			data.jsonp = callbackName

			# Create a callback
			window[callbackName] = (data) =>

				# Check if JSON string
				if typeof data is 'string' and window.JSON?.parse?
					data = JSON.parse(data)

				# Call user function
				options.success.call(@, data)
				

		# Load query
		query = @query(data)

		#scriptTag = @element("#{url}?#{query}")
		#@append(scriptTag)
		@load("#{url}?#{query}")

		return
		

	# Just load a javascript file (do not care about callback)
	@load: (url) ->
		@append(@element(url))