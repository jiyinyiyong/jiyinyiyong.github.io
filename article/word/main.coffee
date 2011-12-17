
class Text
	constructor: (@draw) ->
	baseX: 20
	baseY: 20
	line: 0
	lineHeight: 50
	lineHistory: []
	cha: 0
	chaSize: 24
	chaSpace: 30
	place: 0
	col: 0
	posX: @baseX
	posY: @baseY
	strings: ''
	newPosition: ->
		@posX = @baseX + @cha * (@chaSize+@chaSpace) + @chaSize/2*@col
		@posY = @baseY + @line * @lineHeight + @place*@chaSize/4
	forward: (code) ->
		@strings += code
		console.log @strings
		if @strings.length is 32
			@draw.fillStyle = 'black'
			@draw.font = '10px Ubuntu'
			@draw.fillText (refer @strings), @baseX+(@chaSize+@chaSpace)*@cha, @baseY+@line*@lineHeight+@chaSize+12
			@strings = ''
			console.log 'drawing'
		@newPosition()
		if @place is 0 and @col is 0
			@draw.fillStyle = 'hsl(240,80%,90%)'
			@draw.fillRect @posX, @posY, @chaSize, @chaSize
		@draw.strokeStyle = 'black'
		@draw.beginPath()
		if code[0] is '1'
			@draw.moveTo @posX, @posY
			@draw.lineTo @posX + @chaSize/4, @posY + @chaSize/4
		if code[1] is '1'
			@draw.moveTo @posX+@chaSize/4, @posY
			@draw.lineTo @posX, @posY+@chaSize/4
		if code[2] is '1'
			@draw.moveTo @posX+@chaSize/4, @posY
			@draw.lineTo @posX+@chaSize/2, @posY+@chaSize/4
		if code[3] is '1'
			@draw.moveTo @posX+@chaSize/2, @posY
			@draw.lineTo @posX+@chaSize/4, @posY+@chaSize/4
		@draw.closePath()
		@draw.stroke()
		if @place<3 then @place+=1 else
			@place= 0
			if @col is 0 then @col=1 else
				@col = 0
				@cha += 1
	changeLine: ->
		@lineHistory.push [@cha, @col, @place]
		console.log @lineHistory
		@line += 1
		@cha = 0
		@col = 0
		@place = 0
	backward: ->
		if @place isnt 0 then @place -= 1 else
			@place = 3
			if @col isnt 0 then @col=0 else
				@col = 1
				if @cha isnt 0 then @cha-=1 else
					if @line is 0
						@col = 0
						@place = 0
						return 'ended'
					else
						[@cha, @col, @place] = @lineHistory.pop()
						@line -= 1
		@newPosition()
		if @col is 0 and @place is 0
			@draw.fillStyle = 'white'
			@draw.fillRect @posX, @posY, @chaSize+40, @chaSize+40
		else
			@draw.fillStyle = 'hsl(240,80%,90%)'
			@draw.fillRect @posX, @posY, @chaSize/2+1, @chaSize/4+1
		console.log 'backward'
window.onload = ->
	cvs = document.getElementById 'cvs'
	x = cvs.getContext '2d'
	t = new Text x
	document.onkeydown = (e) =>
		switch e.keyCode
			when 13 then t.changeLine() # Enter to change line
			when 49 then t.forward '0000' # key '1' means '  '
			when 50 then t.forward '0100' # key '2' means '\ '
			when 51 then t.forward '1000' # key '3' means '/ '
			when 52 then t.forward '1100' # key '4' means 'X '
			when 81 then t.forward '0001' # key 'q' means ' \'
			when 87 then t.forward '0101' # key 'w' means '\\'
			when 69 then t.forward '1001' # key 'e' means '/\'
			when 82 then t.forward '1101' # key 'r' means 'X\'
			when 65 then t.forward '0010' # key 'a' means ' /'
			when 83 then t.forward '0110' # key 's' means '\/'
			when 68 then t.forward '1010' # key 'd' means '//'
			when 70 then t.forward '1110' # key 'f' means 'X/'
			when 90 then t.forward '0011' # key 'z' means ' X'
			when 88 then t.forward '0111' # key 'x' means '\X'
			when 67 then t.forward '1011' # key 'c' means '/X'
			when 86 then t.forward '1111' # key 'v' means 'XX'
			when 8 then t.backward() # key Backspace means 'Cancel'
			else console.log e.keyCode
o = '_'
shengmu = [
	'p','ph','b','m',
	o,o,o,o,
	't','th','d','n',
	o,o,o,o,
	'c','ch','z',o,
	's',o,'zs',o,
	'cj','chj','zj','nj',
	'sj',o,'zsj','j',
	o,o,o,'l',
	'k','kh','g','ng',
	'h','q','gh',o,
	o,o,o,o,
	o,o,o,o,
	o,o,o,o,
	o,o,o,o,
	o,o,o,o]
yunmu = [
	'a','ra','ia',o,'o',o,'io',o,
	'ua','rua','ya',o,o,o,'yo',o,
	'an','ren','ian','en','on',o,'ion',o,
	'uan','ruen','yan','uen','uon',o,'yon',o,
	'am','rem','iam','em','om',o,o,o,
	o,o,'yam',o,o,o,'im',o,
	'ang','rang','iang',o,'ong',o,'ing',o,
	'uang','ruang','yang',o,'uong',o,'yk',o,
	'ai','rai','ied','e','au','rau','ieu','eu'
	'uai','ruai','yed','ue',o,o,o,o,
	o,o,o,o,o,o,o,o,
	o,o,o,o,o,o,o,o,
	'ie','ii',o,'ioi','u',o,'iu',o,
	'ye','yi',o,'yoi',o,o,'y',o,
	o,'reng','ieng','eng','ung','rung','yung',o,
	o,'rueng','yeng','ueng','uung',o,'iung',o]
refer = (str) ->
	console.log shengmu.length, yunmu.length
	'returned'
