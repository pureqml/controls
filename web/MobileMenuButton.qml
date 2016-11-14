WebItem {
	width: 54;
	height: 54;
	property enum state { Menu, Back, Cross };
	property bool back;
	cursor: "pointer";
	property color barColor: "white";

	Item {
		property bool isMenu: parent.state == MobileMenuButton.Menu;
		property bool isBack: parent.state == MobileMenuButton.Back;
		property bool isCross: parent.state == MobileMenuButton.Cross;
		width: 28;
		height: 20;
		anchors.centerIn: parent;

		Rectangle {
			x: parent.isBack ? 1 : 4;
			y: parent.isBack ? 3 : parent.isCross ? 10 : 0;
			width: parent.isBack ? 16 : 24;
			height: 2;
			color: parent.parent.barColor;
			transform.rotate: !parent.isMenu ? -45 : 0;
			Behavior on x, y, width, transform { Animation { duration: 400; cssTransition: true; } }
		}

		Rectangle {
			x: 4;
			y: parent.isCross ? 10 : 8;
			width: 24;
			height: 2;
			color: parent.parent.barColor;
			transform.rotate: parent.isBack ? 180 : parent.isCross ? 45 : 0;
			Behavior on transform { Animation { duration: 400; cssTransition: true; } }
		}

		Rectangle {
			x: parent.isBack ? 1 : 4;
			y: parent.isBack ? 13 : parent.isCross ? 10 : 16;
			width: parent.isBack ? 16 : 24;
			height: 2;
			color: parent.parent.barColor;
			transform.rotate: !parent.isMenu ? 45 : 0;
			Behavior on x, y, transform, width { Animation { duration: 400; cssTransition: true; } }
		}
	}
}
