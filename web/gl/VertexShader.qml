Shader {
	create(sourceCode): {
		try {
			return this.createImpl(sourceCode, this._gl.VERTEX_SHADER)
		} catch(e) {
			return null
		}
	}
}
