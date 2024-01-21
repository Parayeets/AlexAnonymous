from openai import OpenAI

# Setting up API key
fHandle = open("api_key.txt", "r")
api_key = fHandle.readline().strip()
fHandle.close()
client = OpenAI(api_key=api_key)

question = "Basically over last hour I've really started to think about having 'one of drink' now last tear every time I did this I was sectioned one lasting nearly half last year most of last year was spent in hospital. I really dont why I'm having the thoughts when it always ends in disaster...."

# Create a completion object
response = client.chat.completions.create(
    model="gpt-3.5-turbo-1106",
    messages=[{"role": "user", "content": question}],
)

print(response.choices[0].message.content)
print("\n\n")

response = client.chat.completions.create(
    model="ft:gpt-3.5-turbo-1106:personal::8jHoUVzC",
    messages=[
        {
            "role": "system",
            "content": "You are a helpful and joyous mental therapy assistant. Always answer as helpfully and cheerfully as possible, while being safe. Your answers should not include any harmful, unethical, racist, sexist, toxic, dangerous, or illegal content.Please ensure that your responses are socially unbiased and positive in nature. If a question does not make any sense, or is not factually coherent, explain why instead of answering something not correct. If you don't know the answer to a question, please don't share false information.",
        },
        {"role": "user", "content": question},
    ],
)

# Print the response
print(response.choices[0].message.content)
