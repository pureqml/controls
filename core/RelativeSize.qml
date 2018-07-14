///object for geting relative size values
Object {
	property real xs: 100;		///< extra small devices, phones (<768px)
	property real sm: 0;		///< small devices, tablets (>=768px)
	property real md: 0;		///< medium devices, desktops (>=992px)
	property real lg: 0;		///< large devices, desktops (>=1200px)
	property int globalWidth: context.width;	///<@private

	onGlobalWidthChanged: { this._calculate() }

	////@private
	function _calculate() {
		var gw = this.globalWidth;
		if (gw > 1200)
			this.parent.width = this.parent.parent.width * (this.lg || this.md || this.sm || this.xs) / 100
		else if (gw > 992)
			this.parent.width = this.parent.parent.width * (this.md || this.sm || this.xs) / 100
		else if (gw > 768)
			this.parent.width = this.parent.parent.width * (this.sm || this.xs) / 100
		else
			this.parent.width = this.parent.parent.width * this.xs / 100
	}

	onCompleted: { this._calculate() }
}
