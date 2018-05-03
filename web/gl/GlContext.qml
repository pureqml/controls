Canvas {
	signal drawScene;

	constructor: {
		var names = ["webgl", "experimental-webgl", "webkit-3d", "moz-webgl"]
		var gl = null
		for (var i = 0; i < names.length; ++i) {
			try {
				gl = this.getContext(names[i]);
			} catch (e) {
				log("Failed to create GL context", e)
			}
			if (gl)
				break;
		}
		this.gl = gl
	}

	render(now): {
		now *= 0.001
		var deltaTime = now - this.then
		this.then = now
		this.drawScene(deltaTime)
		requestAnimationFrame(this.render.bind(this))
	}

	onWidthChanged,
	onHeightChanged: {
		this.gl.viewport(0, 0, this.width, this.height)
	}

	onCompleted: {
		this.then = 0
		requestAnimationFrame(this.render.bind(this))
	}
}
