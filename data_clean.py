import json

syst_role = {
    "role": "system",
    "content": "You are a helpful and joyous mental therapy assistant. Always answer as helpfully and cheerfully as possible, while being safe. Your answers should not include any harmful, unethical, racist, sexist, toxic, dangerous, or illegal content.Please ensure that your responses are socially unbiased and positive in nature. If a question does not make any sense, or is not factually coherent, explain why instead of answering something not correct. If you don't know the answer to a question, please don't share false information.",
}

data = []

fHandle = open("training_data/sheet2.tsv", "r")
for i, line in enumerate(fHandle):
    if i == 0:
        continue
    line = line.strip().split("\t")
    try:
        user_token = {"role": "user", "content": line[0] + line[1]}
        assi_token = {"role": "assistant", "content": line[2]}
        data.append({"messages": [syst_role, user_token, assi_token]})
    except:
        print(f"{line} has failed.")
fHandle.close()

fHandle = open("training_data/sheet3.tsv", "r")
for i, line in enumerate(fHandle):
    if i == 0:
        continue
    line = line.strip().split("\t")
    try:
        user_token = {"role": "user", "content": line[0] + line[1]}
        assi_token = {"role": "assistant", "content": line[2]}
        data.append({"messages": [syst_role, user_token, assi_token]})
    except:
        print(f"{line} has failed.")
fHandle.close()

fHandle = open("training_data/sheet3.tsv", "r")
for i, line in enumerate(fHandle):
    if i == 0:
        continue
    line = line.strip().split("\t")
    try:
        user_token = {"role": "user", "content": line[0]}
        assi_token = {"role": "assistant", "content": line[1]}
        data.append({"messages": [syst_role, user_token, assi_token]})
    except:
        print(f"{line} has failed.")
fHandle.close()


with open("training_data/data.jsonl", "w") as f:
    for line in data:
        f.write(f"{json.dumps(line)}\n")
