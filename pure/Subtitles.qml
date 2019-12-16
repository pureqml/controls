Resource {
	property real progress;		///< bind player progress with this property
	property string text;		///< current subttile text will be changed on corresponded time

	onProgressChanged: {
		var blocks = this._textBlocks
		if (!blocks || blocks.length == 0) {
			this.text = ""
			return
		}

		if (value < blocks[0].startTime || value > blocks[blocks.length - 1].endTime) {
			this.text = ""
			return
		}

		var found = false
		for (var i in blocks) {
			if (value >= blocks[i].startTime && value <= blocks[i].endTime) {
				this.text = blocks[i].text
				found = true
			}
		}

		if (!found)
			this.text = ""
	}

	///turn subtitles off
	turnOff: {
		this._textBlocks = null
		this.text = ""
		this.url = ""
	}

	onDataChanged: {
		var lines = value.split('\n');
		var textBlocks = []
		var startTime = 0
		var endTime = 0
		var blockNumber = 0
		var text = ""
		if (!value)
			return
		for (var i in lines) {
			var line = lines[i].trim()
			if (line == "") {
				if (text.trim() != "")
					textBlocks.push({ text: text, startTime: startTime, endTime: endTime, blockNumber: blockNumber })
				text = ""
				startTime = 0
				endTime = 0
				blockNumber = 0
			} else if (this.digitRegExp.test(line)) {
				blockNumber = parseInt(line)
			} else if (line.indexOf("-->") > 0) {
				var timeStrings = line.split("-->")
				if (timeStrings.length < 2)
					continue
				var startTimeStr = timeStrings[0].trim()
				var endTimeStr = timeStrings[1].trim()
				startTime = this.getTimeDuration(startTimeStr)
				endTime = this.getTimeDuration(endTimeStr)
			} else {
				if (text)
					text += "<br>"
				text += line
			}
		}

		log("got subtitles", textBlocks.length, "lines")
		this._textBlocks = textBlocks
	}

	///@private
	getTimeDuration(str): {
		var parts = str.split(":")
		var res = 0
		var hours = parseInt(parts[0]) * 3600
		var min = parseInt(parts[1]) * 60
		var sec = parseInt(parts[2].split(",")[0])
		res = hours + min + sec
		return res
	}

	constructor: { this.digitRegExp = /^\d+$/; }
}
