Item {
	id: languageSelectorProto;
	property color delegateColor;
	property color delegateTextColor;
	property string currentLangCode;
	width: 50;
	height: 50;

	Image {
		id: currentLanguageIcon;
		anchors.fill: parent;
	}

	MouseArea {
		anchors.fill: parent;
		verticalSwipable: false;
		horizontalSwipable: false;

		onClicked: {
			innerLangView.visible = !innerLangView.visible
		}
	}

	ListModel {
		id: languageModel;
	
		onCountChanged: {
			if (value == 1)
				languageSelectorProto.setLanguageByIndex(0)
		}
	}

	ListView {
		id: innerLangView;
		width: 200;
		height: contentHeight;
		anchors.top: parent.top;
		anchors.right: parent.left;
		visible: false;
		model: languageModel;
		delegate: WebItem {
			property int index: model.index;
			width: parent.width;
			height: 50;

			Rectangle {
				anchors.fill: parent;
				color: languageSelectorProto.delegateColor;
			}

			Text {
				anchors.centerIn: parent;
				text: model.title;
				color: languageSelectorProto.delegateTextColor;
				font.pixelSize: parent.height - 20;
			}

			onClicked: { languageSelectorProto.setLanguageByIndex(this.index) }
		}
	}

	addLanguage(code, title, icon): { languageModel.append({ "code": code, "title": title, "icon": icon }) }

	setLanguageByIndex(index): {
		innerLangView.visible = false
		if (index >= 0 && index < languageModel.count) {
			currentLanguageIcon.source = languageModel.get(index).icon
			languageSelectorProto.currentLangCode = languageModel.get(index).code
		}
	}
}
