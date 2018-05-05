Shader {
	/**@param {string} sourceCode - shader source code
	fragment shader creation function*/
	create(sourceCode): {
		try {
			return this.createImpl(sourceCode, this._gl.FRAGMENT_SHADER)
		} catch(e) {
			return null
		}
	}
}
