SvgBase {
	property int x1;
	property int x2;
	property int y1;
	property int y2;
	property Color color: "red";
	property int width: 2;

	htmlTag: "line";

	/// @internal
	onColorChanged,
	onWidthChanged: {
		this.element.setAttribute('style', 'stroke:' + _globals.core.Color.normalize(this.color) + ';stroke-width:' + this.width +';')
	}

	onX1Changed: {
		this.element.setAttribute('x1', value)
	}
	onX2Changed: {
		this.element.setAttribute('x2', value)
	}
	onY1Changed: {
		this.element.setAttribute('y1', value)
	}
	onY2Changed: {
		this.element.setAttribute('y2', value)
	}
}
