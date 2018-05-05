Shader {
	/**@param {string} sourceCode - shader source code
	vertex shader creation function*/
	create(sourceCode): {
		try {
			return this.createImpl(sourceCode, this._gl.VERTEX_SHADER)
		} catch(e) {
			return null
		}
	}
}
