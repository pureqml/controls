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
				color: "#0f0";
				text: model.text;
			}
		}
	}

	_updatePlayerProperty(name, val): { debugParamsView.model.setProperty(this._params[name].index, "text", val) }

	setPlayer(player): {
		if (!player) {
			log("Player is undefined")
			return
		}

		this._params = {
			"source": { "index": 0, "text": player.source },
			"paused": { "index": 1, "text":  player.paused },
			"volume": { "index": 2, "text": player.volume },
			"muted:": { "index": 3, "text": player.muted },
			"ready": { "index": 4, "text": player.ready },
			"waiting": { "index": 5, "text": player.waiting },
			"seeking": { "index": 6, "text": player.seeking },
			"autoPlay": { "index": 7, "text": player.autoPlay },
			"duration": { "index": 8, "text": player.duration },
			"progress": { "index": 9, "text": player.progress },
			"buffered": { "index": 10, "text": player.buffered }
		}
		var params = this._params

		for (var name in params)
			debugParamsView.model.append({"title": name, "text": params[name].text})

		var self = this
		player.onChanged("source", function(val) { self._updatePlayerProperty("source", val) }.bind(this))
		player.onChanged("paused", function(val) { self._updatePlayerProperty("paused", val) }.bind(this))
		player.onChanged("volume", function(val) { self._updatePlayerProperty("volume", val) }.bind(this))
		player.onChanged("muted", function(val) { self._updatePlayerProperty("muted", val) }.bind(this))
		player.onChanged("ready", function(val) { self._updatePlayerProperty("ready", val) }.bind(this))
		player.onChanged("waiting", function(val) { self._updatePlayerProperty("waiting", val) }.bind(this))
		player.onChanged("seeking", function(val) { self._updatePlayerProperty("seeking", val) }.bind(this))
		player.onChanged("autoPlay", function(val) { self._updatePlayerProperty("autoPlay", val) }.bind(this))
		player.onChanged("duration", function(val) { self._updatePlayerProperty("duration", val) }.bind(this))
		player.onChanged("progress", function(val) { self._updatePlayerProperty("progress", val) }.bind(this))
		player.onChanged("buffered", function(val) { self._updatePlayerProperty("buffered", val) }.bind(this))
	}
}
