Object {
	property bool playing;
	property enum type { Sine, Square, Sawtooth, Triangle };
	property int frequency;
	property int detune;

	Timer {
		id: timeOutTimer;

		start(timeOut): {
			this.interval = timeOut
			this.restart()
		}

		onTriggered: { this.parent.pause() }
	}

	function _update(name, value) {
		switch (name) {
			case 'detune': this._oscillator.frequency.value = value; break
			case 'frequency': this._oscillator.detune.value = value; break
			case 'type':
				switch(value) {
				case this.Sine:		oscillator.type = 'sine'; break
				case this.Square:	oscillator.type = 'square'; break
				case this.Sawtooth:	oscillator.type = 'sawtooth'; break
				case this.Triangle:	oscillator.type = 'triangle'; break
				}
				break
		}

		_globals.core.Item.prototype._update.apply(this, arguments);
	}

	play: {
		if (this.playing)
			return
		this._oscillator.start()
		this.playing = true
	}

	pause: {
		if (!this.playing)
			return
		this._oscillator.stop()
		this.playing = false
	}

	playPause: { this.playing ? this.pause() : this.play() }

	playWithTimeout(ms): {
		this.play()
		timeOutTimer.start(ms)
	}

	onPlayingChanged: {
		if (value)
			return
		delete this._oscillator
		this._oscillator = this._audioCtx.createOscillator()
		this._oscillator.connect(this._audioCtx.destination)
		this.reset()
	}

	constructor: {
		if (window.AudioContext || window.webkitAudioContext) {
			this._audioCtx = new (window.AudioContext || window.webkitAudioContext)();
			this._oscillator = this._audioCtx.createOscillator()
			this._oscillator.connect(this._audioCtx.destination)
			this.reset()
		} else {
			log("Web Audio API not supported")
			return
		}
	}

	reset: {
		var oscillator = this._oscillator
		oscillator.frequency.value = this.frequency
		oscillator.detune.value = this.detune
		switch(this.type) {
		case this.Sine:		oscillator.type = 'sine'
		case this.Square:	oscillator.type = 'square'
		case this.Sawtooth:	oscillator.type = 'sawtooth'
		case this.Triangle:	oscillator.type = 'triangle'
		}
	}
}
