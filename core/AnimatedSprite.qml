Sprite {
	property int totalFrames;
	property int duration;
	property bool repeat;
	property bool running;
	property int interval: duration / totalFrames;

	/// restarts animation from the beginning
	restart: { 
		this._currentIndex = 0
		this.running = true;
	}
	
	/// stop(pause) animation 
	stop: { this.running = false; }

	/// start animation or continue if paused
	start: { this.running = true; }

	onCompleted: {
		if (this.running)
			this._start()
	}

	/** @private */
	function _update(name, value) {
		switch(name) {
			case 'running':
			case 'duration':
			case 'repeat':
			case 'status':
				this._start(); break;
		}
		_globals.controls.core.Sprite.prototype._update.apply(this, arguments);
	}

	function _animate() {
		var pw = this.paintedWidth, w = this.width, ci = this._currentIndex
		var rows = pw / w
		var row = Math.floor(ci / rows)
		var col = ci % rows

		this.offsetX = col * w
		this.offsetY = row * this.height
		this._currentIndex = ++ci % this.totalFrames
	}

	function _start() {
		if (this._interval) {
			clearInterval(this._interval);
			this._interval = undefined;
		}

		if (!this.running || this.status != this.Ready)
			return;

		if (!this._currentIndex)
			this._currentIndex = 0

		var self = this;
		if (this.repeat)
			this._interval = setInterval(function() { self._animate(); }, this.interval);
		else {
			self._countdown = self.totalFrames - self._currentIndex

			this._interval = setInterval(function() {
				if (self._countdown === 0)
					clearInterval(this._interval)
				else {
					--self._countdown;
					self._animate();
				}
				}, this.interval);
		}
	}
}