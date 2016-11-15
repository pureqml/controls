Item {
	id: swipeMenu;
	property Item innerArea: Item { }
	property bool hideable: true;
	property int xDuration: 350;
	property int openWidth: 280;
	property int intPos: 0;
	property int shiftX;
	width: 12;
	height: parent.height;

	show: {
		if (!this.hideable)
			return;
		this.width = this.innerArea.width + 30;
		this.intPos = this.openWidth;
	}

	hide: {
		if (!this.hideable)
			return;
		this.width = 12;
		this.intPos = 0;
	}

	onCompleted: {
		var self = this;
		this.element.on('touchstart', function(e) {
			if (!self.hideable)
				return;

			var touch = e.touches[0];// || e.originalEvent.changedTouches[0];
			self.xDuration = 0; 
			self.shiftX = -self.intPos + touch.pageX; 
			self._prevTime = Date.now();
			self._prevX = touch.pageX;
			self._prevY = touch.pageY;
			self._tx = 0;
			self._speed = 0;
			self._enabled = false;
			self._first = true;
		}.bind(this));

		this.element.on('touchend', function(e) {
			if (!self.hideable)
				return;

			self.xDuration = 350;

			if (self._speed > 0.6)
				self.show();
			else if (self._speed < -0.6)
				self.hide();
			else
				self._tx > (-self.openWidth / 2) ? self.show() : self.hide();
		}.bind(this));

		this.element.on('touchmove', function(e){
			if (!self.hideable)
				return;

			var touch = e.touches[0] || e.changedTouches[0];

			var px = touch.pageX;
			var py = touch.pageY;

			if (self._first) {
				var dx = Math.abs(px - self._prevX);
				var dy = Math.abs(py - self._prevY);
				if (dx === dy)
					return;
				self._enabled = dx > dy
				self._first = false;
			}
			if (self._enabled)
				e.preventDefault();
			else {
				if (px > self.openWidth)
					e.preventDefault();
				//TODO: it breaks up navigation, ...scrollTop equal zero all the time.
				//else if ((self.innerArea.element.dom.scrollTop === 0) && ((py - self._prevY) > 0))
					//e.preventDefault();
				else if (((self.element.height() + self.innerArea.element.dom.scrollTop) === self.innerArea.element.dom.scrollHeight) && ((py - self._prevY) < 0))
					e.preventDefault();

				self._prevY = py;
				return;
			}

			if (px > self.openWidth) {
				self.shiftX = 0; 
				return;
			}
			self._tx = px - self.shiftX;
			if (self._tx >= 0 && self._tx <= self.openWidth) {
				self.intPos = self._tx;
//				self.innerArea.translateX = self._tx;
			}

			var ts = Date.now();
			self._speed = ((px - self._prevX) / (ts - self._prevTime)) * 0.5 + self._speed * 0.5

			self._prevTime = ts;
			self._prevX = px;
		}.bind(this));
	}
}
