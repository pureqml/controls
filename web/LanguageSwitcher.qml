WebItem {
	signal languageChanged;
	property variant languges;
	property int currentIndex;
	property int count;
	width: 50;
	height: 50;

	Image {
		id: currentIcon;
		anchors.fill: parent;
	}

	addLanguage(code, title, icon): {
		this.languges.push({ "code": code, "title": title, "icon": icon })
		++this.count
	}

	onCountChanged: {
		if (this.count == 1 && !this.currentIndex)
			currentIcon.source = this.languges[0].icon
	}

	onClicked: { this.currentIndex = (this.currentIndex + 1) % this.languges.length }

	onCurrentIndexChanged: {
		if (value >= 0 && value < this.count)
			currentIcon.source = this.languges[this.currentIndex].icon
	}

	onCompleted: { this.languges = [] }
}
