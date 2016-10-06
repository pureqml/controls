ListModel {
	VkApiProtocol { id: vkWallProtocol; }

	_fillImpl(data): {
		var wall = data.response.wall
		for (var i in wall)
			this.append(wall[i])
	}

	fill(settings): {
		this.clear()

		vkWallProtocol.wallGet(this._fillImpl.bind(this), settings)
	}
}
