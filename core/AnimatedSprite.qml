Sprite {
	signal triggered;
	signal finished;
	property int frameCount;
	property int currentFrame;
	property int duration;
	property bool repeat;
	property bool running;
	property int interval: duration / frameCount;

	/// start animation or continue if paused
	start: { this.running = true; }

	/// restarts animation from the beginning
	restart: { 
		this.currentFrame = 0
		this.running = true
	}

	/// pause animation 
	pause: { this.running = false; }
	
	/// stop animation 
	stop: {
		this.currentFrame = 0
		this.running = false
	}

	onCompleted: {
		if (this.running)
			this._start()
	}

	/** @private */
	function _update(name, value) {
		switch(name) {
			case 'frameCount':
			case 'interval':
			case 'running':
			case 'duration':
			case 'repeat':
			case 'status':
				this._start(); break;
		}
		_globals.controls.core.Sprite.prototype._update.apply(this, arguments);
	}

	onCurrentFrameChanged: {
		var sw = this.sourceWidth, w = this.width
		var cols = Math.floor(pw / w)
		var col = value % cols
		var row = Math.floor(value / cols)

		this.offsetX = col * w
		this.offsetY = row * this.height
	}

	function _start() {
		if (this._interval) {
			clearInterval(this._interval);
			this._interval = undefined;
		}

		if (!this.running || this.status != this.Ready)
			return;

		var self = this;
		if (self.repeat)
			self._interval = setInterval(function() { 
				self.currentFrame = ++self.currentFrame % self.frameCount
				self.triggered(); 
			}, self.interval);
		else {
			self._countdown = self.frameCount - self.currentFrame

			self._interval = setInterval(function() {
				if (self._countdown === 0) {
					clearInterval(self._interval)
					self.running = false
					self.finished();
				}
				else {
					--self._countdown;
					self.currentFrame = ++self.currentFrame % self.frameCount
					self.triggered();
				}
				}, self.interval);
		}
	}
}