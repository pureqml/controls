Item {
	property string icon;
	property bool scrollable: false;
	property bool show: false;
	property Item content;
	property int contentX;
	property int contentY;
	property Rectangle panel: Rectangle { 
		width: 300;
		height: 300;
		color: "#37474F";
		visible: false;
	}
	width: 50;
	height: 50;

	Rectangle {
		id: navigationContentPanel;
		width: parent.panel.width;
		height: parent.panel.height;
		anchors.top: parent.bottom;
		anchors.right: parent.right;
		anchors.margins: 5;
		color: parent.panel.color;
		radius: parent.panel.radius;
		effects.shadow.blur: 6;
		effects.shadow.color: "#0009";
		effects.shadow.y: 1;
		visible: parent.show;
		clip: true;

		content: Item {
			anchors.fill: parent;
			anchors.topMargin: parent.parent.contentY;
			anchors.leftMargin: parent.parent.contentX;
		}

		onCompleted: {
			if (this.parent.scrollable) {
				this.style('overflow-x', 'hidden')
				this.style('overflow-y', 'scroll')
			}

			var item = this.parent.content
			item.width = this.content.width;
			item.height = this.content.height;
			this.content.element.append(item.element)
		}
	}

	Rectangle {
		width: 23;
		height: width;
		color: parent.panel.color;
		anchors.right: navigationContentPanel.right;
		anchors.bottom: navigationContentPanel.top;
		anchors.rightMargin: 10;
		anchors.bottomMargin: -height / 2 - 5;
		visible: navigationContentPanel.visible;
		rotate: 45;
	}

	WebItem {
		anchors.fill: parent;
		anchors.margins: 5;

		Image {
			anchors.fill: parent;
			source: parent.parent.icon;
			fillMode: Image.PreserveAspectFit;
		}

		onClicked: { this.parent.toggleShow() }
	}

	hide: { this.show = false }
	toggleShow: { this.show = !this.show }
	onShowChanged: { if (value) navigationContentPanel.setFocus() }
}
