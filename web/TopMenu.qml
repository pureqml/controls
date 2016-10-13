Item {
	id: topMenuProto;
	property string icon;
	property bool hasEnoughSpace: true;
	property bool showMenu: false;
	property Item content;
	property Rectangle panel: Rectangle { width: 300; color: "#37474F"; visible: false; }
	height: 50;
	anchors.top: parent.top;
	anchors.left: parent.left;
	anchors.right: parent.right;
	menuItem: Item {
		anchors.fill: parent;
		visible: parent.hasEnoughSpace;
	}

	Rectangle {
		id: topMenuPanel;
		width: parent.panel.width;
		anchors.top: context.top;
		anchors.left: context.left;
		anchors.leftMargin: parent.showMenu ? 0 : (-width - 10);
		anchors.bottom: context.bottom;
		color: parent.panel.color;
		radius: parent.panel.radius;
		effects.shadow.blur: 6;
		effects.shadow.color: "#0009";
		effects.shadow.x: 1;
		visible: !parent.hasEnoughSpace;

		content: Item {
			anchors.top: topMenuIcon.bottom;
			anchors.left: parent.left;
			anchors.right: parent.right;
			anchors.bottom: parent.bottom;
		}

		init: {
			var item = this.parent.content
			item = this.parent.content
			item.width = this.content.width
			item.height = this.content.height
			item.visible = true
			this.content.element.append(item.element)
		}

		Behavior on x { Animation { duration: 300; } }
	}

	WebItem {
		id: topMenuIcon;
		width: height;
		height: parent.height;
		anchors.top: parent.top;
		anchors.left: parent.left;
		visible: !parent.hasEnoughSpace;

		Image {
			anchors.fill: parent;
			source: parent.parent.icon;
			fillMode: Image.PreserveAspectFit;
		}

		onClicked: { this.parent.toggleShow() }
	}

	toggleShow: { this.showMenu = !this.showMenu }
	onWidthChanged: { topMenuProto.hasEnoughSpace = value >= this.content.width }

	function _update(name, value) {
		switch(name) {
		case 'content':
			if (value)
				value.visible = false
			break
		}
		_globals.core.Item.prototype._update.apply(this, arguments);
	}

	onCompleted: {
		var item = this.content
		item.width = this.width
		item.height = this.height
		item.visible = true
		this.menuItem.element.append(item.element)
		//topMenuPanel.init()
	}
}
