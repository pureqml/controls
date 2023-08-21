SvgBase {
	property int x1;
	property int x2;
	property int y1;
	property int y2;
	property Color color: "red";
	property string fill: "none";
	property int width: 2;

	htmlTag: "path";

	onColorChanged: {
		this.element.setAttribute('stroke', _globals.core.Color.normalize(value))
	}

	onFillChanged: {
		this.element.setAttribute('fill', value)
	}

	onWidthChanged: {
		this.element.setAttribute('stroke-width', value)
	}

	onX1Changed,
	onX2Changed,
	onY1Changed,
	onY2Changed: {
		this.element.setAttribute('d', this.buildPath())
	}

	function buildPath() {
		var x1 = this.x1, x2 = this.x2, y1 = this.y1, y2 = this.y2
		var xb = (x2 - x1) / 2 + x1

		var d = "M" + x1 + "," + y1 + " C" + xb + "," + y1 + " " + xb + "," + y2 + " " + x2 + "," + y2
	 	return d;
	}
}
