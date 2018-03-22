Shader {
	create(sourceCode): {
		try {
			return this.createImpl(sourceCode, this._gl.FRAGMENT_SHADER)
		} catch(e) {
			return null
		}
	}
}
