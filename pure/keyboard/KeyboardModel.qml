ListModel {
	id: keyboardModel;
	property enum mode { LowerCase, UpperCase, Special };
	property enum language { Eng, Rus };
	/*property string rusLetters: "абвгдеёжзийклмнопрстуфхцчшщъыьэюя.,1234567890";*/
	/*property string engLetters: "abcdefghijklmnopqrstuvwxyz.,1234567890";*/
	/*property string rusLettersUp: "АБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯ.,1234567890";*/
	/*property string engLettersUp: "ABCDEFGHIJKLMNOPQRSTUVWXYZ.,1234567890";*/
	/*property string special: "!#$%&+?/:;_-*@";*/
	/*property string letters: mode == Special ? special :*/
		/*language == 0 && mode == LowerCase ? rusLetters :*/
		/*language == 0 && mode == UpperCase ? rusLettersUp :*/
		/*language == 1 && mode == LowerCase ? engLetters : engLettersUp;*/

	onModeChanged: { this.updateLetters() }
	onLanguageChanged: { this.updateLetters() }

	fill: {
		this.clear();
		this.append({});
		this.append({});
		if (this.mode == this.Special)
			return;
		this.append({});
		this.append({});
		this.append({});
		this.append({});
		this.append({});
		if (this.language == this.Rus)
			this.append({});
	}

	switchLanguage: {
		this.language = this.language == this.Rus ? this.Eng : this.Rus
		this.fill();
	}

	switchCase: {
		this.mode = (++this.mode % 3);
		this.fill();
	}

	getCaseIndex: { return this.mode == this.LowerCase ? 0 : 1 }

	updateLetters: {
		var mode = this.mode
		if (mode == this.Special)
			this.letters = this._special
		else
			this.letters = this.language == this.Rus ? this._rusLetters[this.getCaseIndex()] : this._engLetters[this.getCaseIndex()]
	}

	onCompleted: {
		this._rusLetters = ["абвгдеёжзийклмнопрстуфхцчшщъыьэюя.,1234567890", "АБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯ.,1234567890"];
		this._engLetters = ["abcdefghijklmnopqrstuvwxyz.,1234567890", "ABCDEFGHIJKLMNOPQRSTUVWXYZ.,1234567890"];
		this._special = "!#$%&+?/:;_-*@"
		this.updateLetters()
		this.fill();
	}
}
