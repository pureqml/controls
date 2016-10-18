Object {
	property real xs: 100;
	property real sm: 0;
	property real md: 0;
	property real lg: 0;
	property int globalWidth: context.width;

	onGlobalWidthChanged: {
		var gw = value;
		if (gw > 1200)
			this.parent.width = this.parent.parent.width * (this.lg || this.md || this.sm || this.xs) / 100
		else if (gw > 992)
			this.parent.width = this.parent.parent.width * (this.md || this.sm || this.xs) / 100
		else if (gw > 768)
			this.parent.width = this.parent.parent.width * (this.sm || this.xs) / 100
		else
			this.parent.width = this.parent.parent.width * this.xs / 100

		log ("Relative width", value, this.parent.width)
	}
}