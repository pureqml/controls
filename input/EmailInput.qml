///email input
TextInput {
	property bool valid;	///< is typed email valid or not flag
	type: "email";

	onTextChanged: {
		if (!this.re)
			this.re = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
		this.valid = this.re.test(value);
	}
}
