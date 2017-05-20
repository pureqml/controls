/// Object, which can then be populated by data, and played via an AudioBuffer
Object {
	property int length;			///< Read only integer property representing the length, in sample-frames, of the PCM data stored in the buffer.
	property int channelsCount;		///< Returns an integer representing the number of discrete audio channels described by the PCM data stored in the buffer.
	property real sampleRate;		///< Read only real property representing the sample rate, in samples per second, of the PCM data stored in the buffer.
	property real duration;			///< Read only real property representing the duration, in seconds, of the PCM data stored in the buffer.

	///@private
	onLengthChanged, onChannelsCountChanged: { this.reset() }

	/// Play audio buffer
	play: { this._source.start(); }

	/// Set audio buffer
	setBuffer(data): { this._data = data; this.length = data.length }

	///@private
	reset: {
		var channels = this.channelsCount;
		var audioCtx = this._audioCtx
		var frameCount = audioCtx.sampleRate * channels;
		var myArrayBuffer = audioCtx.createBuffer(channels, frameCount, audioCtx.sampleRate);
		var source = audioCtx.createBufferSource();
		source.buffer = this._data;
		source.connect(audioCtx.destination);
		this._source = source

		this.sampleRate = audioCtx.sampleRate
	}

	///@private
	constructor: {
		if (window.AudioContext || window.webkitAudioContext) {
			this._audioCtx = new (window.AudioContext || window.webkitAudioContext)();
			this.reset();
		} else {
			log("Web Audio API not supported")
			return
		}
	}
}
