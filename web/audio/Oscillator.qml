/// Object generates sound and play it via web audio API
Object {
	property enum type { Sine, Square, Sawtooth, Triangle };	///< signal type enum: Sine, Square, Sawtooth or Triangle
	property bool playing;	///< is oscillator playing right now
	property int frequency;	///< signal frequency value
	property int detune;	///< representing detuning of oscillation in cents

	Timer {
		id: timeOutTimer;

		start(timeOut): {
			this.interval = timeOut
			this.restart()
		}

		onTriggered: { this.parent.pause() }
	}

	///@private
	onDetuneChanged: { this._oscillator.frequency.value = value; }

	///@private
	onFrequencyChanged: { this._oscillator.detune.value = value; }

	///@private
	onTypeChanged: {
		var oscillator = this._oscillator
		switch(value) {
		case this.Sine:		oscillator.type = 'sine'; break
		case this.Square:	oscillator.type = 'square'; break
		case this.Sawtooth:	oscillator.type = 'sawtooth'; break
		case this.Triangle:	oscillator.type = 'triangle'; break
		}
	}

	///< paly generated sound
	play: {
		if (this.playing)
			return
		this._oscillator.start()
		this.playing = true
	}

	///< pause generated sound
	pause: {
		if (!this.playing)
			return
		this._oscillator.stop()
		this.playing = false
	}

	///< play/pause generated sound
	playPause: { this.playing ? this.pause() : this.play() }

	/**@param ms:int time interval in milliseconds
	play generated sound 'ms' milliseconds*/
	playWithTimeout(ms): {
		this.play()
		timeOutTimer.start(ms)
	}

	///@private
	onPlayingChanged: {
		if (value)
			return
		delete this._oscillator
		this._oscillator = this._audioCtx.createOscillator()
		this._oscillator.connect(this._audioCtx.destination)
		this.reset()
	}

	///@private
	constructor: {
		if (window.AudioContext || window.webkitAudioContext) {
			this._audioCtx = new (window.AudioContext || window.webkitAudioContext)();
			this._oscillator = this._audioCtx.createOscillator()
			this._oscillator.connect(this._audioCtx.destination)
		} else {
			log("Web Audio API not supported")
			return
		}
	}

	///@private
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

	///@private
	onCompleted: { this.reset() }
}
