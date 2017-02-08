Sprite {
	signal triggered;
	property int totalFrames;
	property int currentFrame;
	property int duration;
	property bool repeat;
	property bool running;
	property int interval: duration / totalFrames;

	/// restarts animation from the beginning
	restart: { 
		this.currentFrame = 0
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
			case 'totalFrames':
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
		log ("onCurrentFrameChanged", value)
		var pw = this.paintedWidth, w = this.width
		var rows = pw / w
		var row = Math.floor(value / rows)
		var col = value % rows

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
				self.currentFrame = ++self.currentFrame % self.totalFrames
				self.triggered(); 
			}, self.interval);
		else {
			self._countdown = self.totalFrames - self.currentFrame

			self._interval = setInterval(function() {
				if (self._countdown === 0) {
					clearInterval(self._interval)
					self.running = false
				}
				else {
					--self._countdown;
					self.currentFrame = ++self.currentFrame % self.totalFrames
					self.triggered(); 
				}
				}, self.interval);
		}
	}
}