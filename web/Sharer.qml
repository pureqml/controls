///object for sharing URL in corresponded social network
Object {
	property enum socailNetwork { GPlus, Facebook, Vk, Twitter };	///< social network name
	property string url;	///< URL you want to share

	onSocailNetworkChanged: {
		switch(value) {
		case this.GPlus:	this.href = 'https://plus.google.com/share?url='; break
		case this.Facebook:	this.href = 'https://www.facebook.com/sharer/sharer.php?s=100&amp;p%5Burl%5D='; break
		case this.Vk:		this.href = 'https://vkontakte.ru/share.php?url='; break
		case this.Twitter:	this.href = 'https://twitter.com/share?url='; break
		}
	}

	///load URL
	open: {
		if (!this.url) {
			log("url is undefined!")
			return
		}
		window.open(this.href + this.url + '%2Fauth%2Flogin')
	}

	///set location to corresponded URL
	redirect: {
		if (!this.url) {
			log("url is undefined!")
			return
		}
		window.location = this.href + this.url + '%2Fauth%2Flogin'
	}
}
