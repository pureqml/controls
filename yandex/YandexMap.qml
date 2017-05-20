Item {
	property real centerLongitude;
	property real centerLatitude;
	property int zoom;

	onCenterLongitudeChanged, onCenterLatitudeChanged, onZoomChanged: { this._updateCenter() }

	constructor: {
		if (!window.YMaps) {
			log("YMaps not found! Probably you forgot to include yandex map api:")
			log('<script charset="utf-8" src="https://api-maps.yandex.ru/1.1/index.xml" type="text/javascript"></script>')
			return
		}
		this._api = window.YMaps
		var map = new this._api.Map(this.element.dom)
		this._map = map
		log("Map", map)
	}

	function _updateCenter() {
		if (!this._map) {
			log("Map not initizlized")
			return
		}
		var center = new this._api.GeoPoint(this.centerLongitude, this.centerLatitude);
		this._map.setCenter(center, this.zoom)
	}

	getUserLocation: { return this._api ? this._api.location : undefined }
}
