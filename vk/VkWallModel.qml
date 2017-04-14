/// this model wich get data from the 'vkontakte' socail network wall
ListModel {
	signal error;
	property int ownerId;

	VkApi { id: vkApi; }

	///@private
	_fillImpl(data): {
		if (data.error) {
			log("Request error", data.error)
			this.error(data.error)
		} else {
			var wall = data.response.wall
			// first wall[0] is for total entries count
			for (var i = 1; i < wall.length; ++i)
				this.append(wall[i])
		}
	}

	/// fill model with data from 'ownerId' wall with default parameters
	fillDefault: {
		this.clear()

		if (!this.ownerId) {
			log("Failed to get wall data - owner ID is undefined")
			return
		}

		var settings = {
			extended: 1,
			count: 100,
			owner_id: this.ownerId
		}
		vkApi.wallGet(this._fillImpl.bind(this), settings)
	}

	/**@param settings:Object additional request parameters
	 fill model with data from the wall with customized settings such as count, extended etc.*/
	fillCustom(settings): {
		this.clear()

		if (!settings.owner_id && this.ownerId)
			settings.owner_id = this.ownerId

		vkApi.wallGet(this._fillImpl.bind(this), settings)
	}
}
