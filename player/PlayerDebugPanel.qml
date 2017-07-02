Item {
	id: playerDebugPanelProto;
	anchors.fill: parent;

	ListView {
		id: debugParamsView;
		anchors.fill: parent;
		anchors.margins: 10;
		spacing: 10;
		model: ListModel { }
		delegate: Item {
			width: parent.width;
			height: 30;

			Text {
				font.pixelSize: 24;
				color: "#f00";
				text: model.title;
			}

			Text {
				anchors.left: parent.left;
				anchors.leftMargin: 150;
				font.pixelSize: 24;
				color: "#eee";
				text: model.text;
			}
		}
	}

	_updatePlayerProperty(param, val): {
		debugParamsView.model.setProperty(param.index, "text", val)
	}

	setPlayer(player): {
		if (!player) {
			log("Player is undefined")
			return
		}

		var params = {
			"source": { "index": 0, "text": player.source },
			"paused": { "index": 1, "text":  player.paused },
			"volume": { "index": 2, "text": player.volume },
			"muted:": { "index": 3, "text": player.muted },
			"ready": { "index": 4, "text": player.ready },
			"waiting": { "index": 5, "text": player.waiting },
			"seeking": { "index": 6, "text": player.seeking },
			"autoPlay": { "index": 7, "text": player.autoPlay },
			"duration": { "index": 8, "text": player.duration },
			"progress": { "index": 8, "text": player.progress },
			"buffered": { "index": 8, "text": player.buffered }
		}

		var self = this
		for (var name in params) {
			player.onChanged(name, function(val) { self._updatePlayerProperty(params[name], val) }.bind(this))
			debugParamsView.model.append({"title": name, "text": params[name].text})
		}

	}
}
