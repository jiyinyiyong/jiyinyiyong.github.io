
json2page = (json) ->
	o = console.log
	data = 'html':
			'head':
				'title': 'json2page'
				'meta':
					'attr':
						'charset': 'utf-8'
				'css':
					'body':
						'color': 'red'
				'script':
					'attr':
						'type': 'application/javascript'
					'text': 'console.log("a");'
			'body':
				'div':
					'attr':
						'width': '200px'
						'height': '400px'
					'style':
						'background': 'hsl(0,0%,0%)'
						'color': 'white'
						'height': '300px'
	json2style = (json_data) ->
		style = ' style="'
		for key, value of json_data
			key = (key.match /([a-z]|-)+/)[0]
			if typeof value is 'number'
				value = "#{value}px"
			style += "#{key}: #{value};"
		style += '"'
		return style
	json2attr = (json_data) ->
		attrs = ''
		for key, value of json_data
			key = (key.match /([a-z]|-)+/)[0]
			if key is 'style'
				attrs += json2style value
			else
				attrs += "#{key}=\"#{value}\""
		return attrs
	json2css = (json_data) ->
		css = '<style>'
		for sub_key1, sub_value1 of json_data
			css += sub_key1 + '{'
			for sub_key2, sub_value2 of sub_value1
				if typeof sub_value2 is 'number'
					sub_value2 = "#{sub_value2}px"
				css += "#{sub_key2}: #{sub_value2};"
			css += '}'
		css += '</style>'
		return css
	json2page = (json_data)->
		page = ''
		# console.log json_data
		for key, value of json_data
			key = (key.match /([a-z]|-)+/)[0]
			if key is 'text'
				page += value
			else if typeof value is 'string'
				elem = "<#{key}>"
				elem += value + ''
				elem += "</#{key}>"
				return elem
			else if key is 'css'
				page += json2css value
			else
				# console.log key
				page += "<#{key}"
				if value['attr']
					page += ' '
					page += json2attr value['attr']
				if value['style']
					page += json2style value['style']
				page += '>'
				for sub_key, sub_value of value
					sub_key = (sub_key.match /([a-z]|-)+/)[0]
					unless sub_key in ['attr', 'style']
						sub_json_data = {}
						sub_json_data[sub_key] = sub_value
						page += json2page sub_json_data
				page += "</#{key}>"
		return page
	# console.log json2page data
	return (json2page json)
exports.json2page = json2page unless window
window.json2page = json2page if window
