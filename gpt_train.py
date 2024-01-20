from openai import OpenAI

# Setting up API key
fHandle = open("api_key.txt", "r")
api_key = fHandle.readline().strip()
fHandle.close()
client = OpenAI(api_key=api_key)

# Create a completion object
# response = client.chat.completions.create(
#    model="gpt-3.5-turbo-1106",
#    messages=[{"role": "user", "content": "What is the meaning of life?"}],
# )

# Print the response
# print(response)
