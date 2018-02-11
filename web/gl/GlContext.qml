Canvas {
	constructor: {
		var names = ["webgl", "experimental-webgl", "webkit-3d", "moz-webgl"]
		var gl = null
		for (var i = 0; i < names.length; ++i) {
			try {
				gl = this.getContext(names[i]);
			} catch(e) {}
			if (gl)
				break;
		}
		this.gl = gl
	}

	onWidthChanged,
	onHeightChanged: {
		var gl = this.gl
		gl.viewport(0, 0, this.width, this.height);
	}
}
