from openai import OpenAI

# Setting up API key
fHandle = open("api_key.txt", "r")
api_key = fHandle.readline().strip()
fHandle.close()
client = OpenAI(api_key=api_key)

question = "I've been thinking of drinking again lately. I'm having trouble staying motivated at work"

# Create a completion object
response = client.chat.completions.create(
    model="gpt-3.5-turbo-1106",
    messages=[{"role": "user", "content": question}],
)

print(response.choices[0].message.content)
