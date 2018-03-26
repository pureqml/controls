/// sprite image animation item
Sprite {
	signal finished;			///< animation was ended signal
	signal triggered;			///< frame changed signal
	property int frameCount;	///< frames in duration value
	property int currentFrame;	///< displayed frame index
	property int duration;		///< animation time interval in milliseconds
	property int interval: duration / frameCount;	///< read only property, time interval between each frames
	property bool repeat;		///< repeat animation flag
	property bool running;		///< animation is running flag

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

	///@private
	onCompleted: {
		if (this.running)
			this._start()
	}

	///@private
	onRepeatChanged,
	onStatusChanged,
	onRunningChanged,
	onDurationChanged,
	onIntervalChanged,
	onFrameCountChanged: {
		this._start();
	}

	///@private
	onCurrentFrameChanged: {
		var sw = this.sourceWidth, w = this.width
		var cols = Math.floor(sw / w)
		var col = value % cols
		var row = Math.floor(value / cols)

		this.offsetX = col * w
		this.offsetY = row * this.height
	}

	///@private
	function _start() {
		if (this._interval) {
			clearInterval(this._interval);
			this._interval = undefined;
		}

		if (!this.running || this.status != this.Ready)
			return;

		var self = this;

		if (self.repeat)
			self._interval = setInterval(this._context.wrapNativeCallback(function() {
				self.currentFrame = ++self.currentFrame % self.frameCount
				self.triggered();
			}), self.interval);
		else {
			self._countdown = self.frameCount - self.currentFrame

			self._interval = setInterval(this._context.wrapNativeCallback(function() {
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
				}), self.interval);
		}
	}
}
