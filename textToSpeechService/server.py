from flask import Flask, send_file, request
from textToSpeech import generateSpeech
app = Flask(__name__)

@app.route('/')
def test():
    return 'Hello World!'

@app.route('/tts/')
def tts():
    text = request.args.get('text')
    voice = request.args.get('voice')
    speech = generateSpeech("output.wav", text, voice)
    return send_file(speech, mimetype='audio/wav')


if __name__ == '__main__':
    app.run(debug=True) # TODO: Set debug=False before deployment