///panel with system info within (OS, platform, vendor, layout type etc.)
Rectangle {
	width: 600;
	height: debugInfoContent.contentHeight;
	anchors.top: parent.top;
	anchors.left: parent.left;
	anchors.margins: 10;
	color: "#000c";
	border.width: 2;
	border.color: "#ccc";
	radius: 10;
	focus: false;

	Column {
		id: debugInfoContent;
		anchors.top: parent.top;
		anchors.left: parent.left;
		anchors.right: parent.right;
		anchors.leftMargin: 10;
		anchors.rightMargin: 10;

		DebugInfoItem {
			label: "LayoutType:";
			value: context.system.layoutType == System.MobileS ? "MobileS" :
				context.system.layoutType == System.MobileM ? "MobileM" :
				context.system.layoutType == System.Tablet ? "Tablet" :
				context.system.layoutType == System.Laptop ? "Laptop" :
				context.system.layoutType == System.LaptopL ? "LaptopL" :
				context.system.layoutType == System.MobileL ? "MobileL" : "Laptop4K";
		}

		DebugInfoItem {
			label: "Device:";

			onCompleted: {
				this.value = this._context.system.device == this._context.system.Desktop ? "Desktop" :
					this._context.system.device == this._context.system.Tv ? "Tv" : "Mobile";
			}
		}

		DebugInfoItem {
			label: "PageActive:";
			value: context.system.pageActive;
		}

		DebugInfoItem {
			label: "Vendor:";
			value: context.system.vendor;
		}

		DebugInfoItem {
			label: "Browser:";
			value: context.system.browser;
		}

		DebugInfoItem {
			label: "Language:";
			value: context.system.language;
		}

		DebugInfoItem {
			label: "OS:";
			value: context.system.os;
		}

		DebugInfoItem {
			label: "Webkit support:";
			value: context.system.webkit;
		}

		DebugInfoItem {
			label: "3dTransforms:";
			value: context.system.support3dTransforms;
		}

		DebugInfoItem {
			label: "Transforms:";
			value: context.system.support3dTransforms;
		}

		DebugInfoItem {
			label: "Transitions:";
			value: context.system.supportTransitions;
		}

		DebugInfoItem {
			label: "Orientation:";
			value: context.system.portrait ? "Portrait" : "Landscape";
		}

		DebugInfoItem {
			label: "Agent:";
			value: context.system.userAgent;
		}
	}
}
