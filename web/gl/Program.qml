Object {
	constructor: {
		if (!this.parent || !this.parent.gl) {
			log("Place 'Program' in 'GlContext'")
			return
		}

		var gl = this.parent.gl
		this._program = gl.createProgram()
		this._gl = gl
	}

	attachShader(shader): { this._gl.attachShader(this._program, shader) }

	linkProgram: { this._gl.linkProgram(this._program) }

	create: {
		var gl = this._gl
		var program = this._program;
		if (!gl.getProgramParameter(program, gl.LINK_STATUS)) {
			alert('Unable to initialize the shader program: ' + gl.getProgramInfoLog(program))
			return null
		}
		return program
	}
}
