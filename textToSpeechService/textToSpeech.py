import elevenlabs as el
from openai import OpenAI
import os

here = os.path.dirname(os.path.abspath(__file__))

# ElevenLabs
filename = os.path.join(here, 'el_api_key.txt')
fHandle = open(filename, "r")
api_key = fHandle.readline().strip()
fHandle.close()

# OpenAI
filename = os.path.join(here, 'api_key.txt')
fHandle = open(filename, "r")
openai_api_key = fHandle.readline().strip()
fHandle.close()

el.set_api_key(api_key)

def generateSpeech(path, text, voice):
	"""Generates a speech file (WAV) from the given text prompt and the voice name.
	Stores in path"""
	full_path = os.path.join(here, path)
	audio = el.generate(text=text,
						voice=voice,
						model='eleven_multilingual_v2')
	el.save(audio=audio, filename=full_path)
	return full_path

def generateText(path):
	"""Generates text from the given speech file (WAV)"""
	client = OpenAI(api_key=openai_api_key)

	with open(path, "rb") as audio_file:
		transcript = client.audio.transcriptions.create(
		model="whisper-1", 
		file=audio_file
		)
	return transcript.text

if __name__ == "__main__":
	# generateSpeech("test.wav", "I know what it's like to struggle with addiction motherfuckahs!", "Leo Gura")
	print(generateText(os.path.join(here, 'recording.m4a')))