TextInput {
	property bool correct;

	onTextChanged: {
		if (!this.re)
			this.re = /^[a-zA-Z0-9][a-zA-Z0-9-]{1,61}[a-zA-Z0-9]$/;
		this.correct = this.re.test(value);
	}
}
