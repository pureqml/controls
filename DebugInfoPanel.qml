Rectangle {
	width: 400;
	height: debugInfoContent.contentHeight;
	anchors.top: parent.top;
	anchors.left: parent.left;
	anchors.margins: 10;
	color: "#000c";
	border.width: 2;
	border.color: "#ccc";
	radius: 10;
	focus: false;

	//property bool ;
	//property bool portrait: parent.width < parent.height;
	//property bool landscape: !portrait;
	//property int contextWidth: parent.width;
	//property int contextHeight: parent.height;

	Column {
		id: debugInfoContent;
		anchors.top: parent.top;
		anchors.left: parent.left;
		anchors.right: parent.right;
		anchors.margins: 10;

		Item {
			height: 50;
			anchors.left: parent.left;
			anchors.right: parent.right;

			Text {
				height: parent.height;
				anchors.left: parent.left;
				color: "#80D8FF";
				font.pixelSize: 24;
				text: "LayoutType:";
			}

			Text {
				height: parent.height;
				anchors.left: parent.left;
				anchors.leftMargin: 200;
				color: "#fff";
				font.pixelSize: 24;
				text: context.system.layoutType == System.MobileS ? "MobileS" : 
					context.system.layoutType == System.MobileM ? "MobileM" : 
					context.system.layoutType == System.Tablet ? "Tablet" : 
					context.system.layoutType == System.Laptop ? "Laptop" : 
					context.system.layoutType == System.LaptopL ? "LaptopL" : 
					context.system.layoutType == System.MobileL ? "MobileL" : "Laptop4K";
			}
		}

		Item {
			height: 50;
			anchors.left: parent.left;
			anchors.right: parent.right;

			Text {
				height: parent.height;
				anchors.left: parent.left;
				color: "#80D8FF";
				font.pixelSize: 24;
				text: "Device:";
			}

			Text {
				height: parent.height;
				anchors.left: parent.left;
				anchors.leftMargin: 200;
				color: "#fff";
				font.pixelSize: 24;
				text: context.system.device == System.Desktop ? "Desktop" : 
					context.system.device == System.Tv ? "Tv" : "Mobile";
			}
		}

		Item {
			height: 50;
			anchors.left: parent.left;
			anchors.right: parent.right;

			Text {
				height: parent.height;
				anchors.left: parent.left;
				color: "#80D8FF";
				font.pixelSize: 24;
				text: "PageActive:";
			}

			Text {
				height: parent.height;
				anchors.left: parent.left;
				anchors.leftMargin: 200;
				color: "#fff";
				font.pixelSize: 24;
				text: context.system.pageActive;
			}
		}

		Item {
			height: 50;
			anchors.left: parent.left;
			anchors.right: parent.right;

			Text {
				height: parent.height;
				anchors.left: parent.left;
				color: "#80D8FF";
				font.pixelSize: 24;
				text: "Vendor:";
			}

			Text {
				height: parent.height;
				anchors.left: parent.left;
				anchors.leftMargin: 200;
				color: "#fff";
				font.pixelSize: 24;
				text: context.system.vendor;
			}
		}

		Item {
			height: 50;
			anchors.left: parent.left;
			anchors.right: parent.right;

			Text {
				height: parent.height;
				anchors.left: parent.left;
				color: "#80D8FF";
				font.pixelSize: 24;
				text: "Browser:";
			}

			Text {
				height: parent.height;
				anchors.left: parent.left;
				anchors.leftMargin: 200;
				color: "#fff";
				font.pixelSize: 24;
				text: context.system.browser;
			}
		}

		Item {
			height: 50;
			anchors.left: parent.left;
			anchors.right: parent.right;

			Text {
				height: parent.height;
				anchors.left: parent.left;
				color: "#80D8FF";
				font.pixelSize: 24;
				text: "Language:";
			}

			Text {
				height: parent.height;
				anchors.left: parent.left;
				anchors.leftMargin: 200;
				color: "#fff";
				font.pixelSize: 24;
				text: context.system.language;
			}
		}

		Item {
			height: 50;
			anchors.left: parent.left;
			anchors.right: parent.right;

			Text {
				height: parent.height;
				anchors.left: parent.left;
				color: "#80D8FF";
				font.pixelSize: 24;
				text: "OS:";
			}

			Text {
				height: parent.height;
				anchors.left: parent.left;
				anchors.leftMargin: 200;
				color: "#fff";
				font.pixelSize: 24;
				text: context.system.os;
			}
		}



		Item {
			height: 50;
			anchors.left: parent.left;
			anchors.right: parent.right;

			Text {
				height: parent.height;
				anchors.left: parent.left;
				color: "#80D8FF";
				font.pixelSize: 24;
				text: "Webkit support:";
			}

			Text {
				height: parent.height;
				anchors.left: parent.left;
				anchors.leftMargin: 200;
				color: "#fff";
				font.pixelSize: 24;
				text: context.system.webkit;
			}
		}

		Item {
			height: 50;
			anchors.left: parent.left;
			anchors.right: parent.right;

			Text {
				height: parent.height;
				anchors.left: parent.left;
				color: "#80D8FF";
				font.pixelSize: 24;
				text: "3dTransforms:";
			}

			Text {
				height: parent.height;
				anchors.left: parent.left;
				anchors.leftMargin: 200;
				color: "#fff";
				font.pixelSize: 24;
				text: context.system.support3dTransforms;
			}
		}

		Item {
			height: 50;
			anchors.left: parent.left;
			anchors.right: parent.right;

			Text {
				height: parent.height;
				anchors.left: parent.left;
				color: "#80D8FF";
				font.pixelSize: 24;
				text: "Transforms:";
			}

			Text {
				height: parent.height;
				anchors.left: parent.left;
				anchors.leftMargin: 200;
				color: "#fff";
				font.pixelSize: 24;
				text: context.system.supportTransforms;
			}
		}

		Item {
			height: 50;
			anchors.left: parent.left;
			anchors.right: parent.right;

			Text {
				height: parent.height;
				anchors.left: parent.left;
				color: "#80D8FF";
				font.pixelSize: 24;
				text: "Orientation:";
			}

			Text {
				height: parent.height;
				anchors.left: parent.left;
				anchors.leftMargin: 200;
				color: "#fff";
				font.pixelSize: 24;
				text: context.system.portrait ? "Portrait" : "Landscape";
			}
		}
	}
}
