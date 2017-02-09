Item {
	id: keyboardProto;
	signal keySelected;
	signal backspase;
	property int currentRow;
	width: 420;
	height: 480;

	KeyboardModel { id: keyboardModel; }

	ListView {
		anchors.fill: parent;
		spacing: 5;
		model: keyboardModel;
		keyNavigationWraps: false;
		delegate: Item {
			width: parent.width;
			height: 45;

			ListView {
				anchors.fill: parent;
				orientation: ListView.Horizontal;
				spacing: 5;
				model: KeyboardRowModel {
					parentModel: keyboardModel;
					begin: model.index * 7;
					end: begin + 7;
				}
				delegate: KeyboardDelegate { }

				onCurrentIndexChanged: { keyboardProto.currentRow = this.currentIndex; }
				onLeftPressed: { --this.currentIndex; }

				onRightPressed: {
					if (this.currentIndex == this.count - 1)
						event.accepted = false;
					else
						++this.currentIndex;
				}

				onSelectPressed: {
					var row = this.model.get(this.currentIndex);
					if (row.text)
						keyboardProto.keySelected(row.text);
					else
						keyboardProto.backspase();
				}

				onActiveFocusChanged: {
					if (this.activeFocus)
						this.currentIndex = keyboardProto.currentRow;
				}
			}
		}

		//TODO: Try something better this hardcode.
		onDownPressed: {
			if (keyboardModel.mode != KeyboardModel.Special && this.currentIndex == this.count - 3) {
				if (keyboardProto.currentRow == 3 || keyboardProto.currentRow == 4)
					keyboardProto.currentRow = 3;
				if (keyboardProto.currentRow == 5 || keyboardProto.currentRow == 6)
					keyboardProto.currentRow = 4;
			} else if (keyboardModel.mode != KeyboardModel.Special && this.currentIndex == this.count - 2) {
				if (keyboardProto.currentRow == 0 || keyboardProto.currentRow == 1)
					keyboardProto.currentRow = 0;
				if (keyboardProto.currentRow == 2 || keyboardProto.currentRow == 3)
					keyboardProto.currentRow = 1;
				if (keyboardProto.currentRow == 4)
					keyboardProto.currentRow = 2;
			}
			this.currentIndex++;
		}

		onUpPressed: {
			if (keyboardModel.mode != KeyboardModel.Special && this.currentIndex == this.count - 1) {
				if (keyboardProto.currentRow == 1)
					keyboardProto.currentRow = 3;
				if (keyboardProto.currentRow == 2)
					keyboardProto.currentRow = 4;
			} else if (keyboardModel.mode != KeyboardModel.Special && this.currentIndex == this.count - 2) {
				if (keyboardProto.currentRow == 4)
					keyboardProto.currentRow = 5;
			}
			this.currentIndex--;
		}
	}

	switchLanguage: { keyboardModel.switchLanguage(); }
	switchCase: { keyboardModel.switchCase(); }
}
