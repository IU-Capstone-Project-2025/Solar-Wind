import json

def json_inputer():
    def input_iter():
        while (line:=input().strip())!="" and line is not None:
            yield line
    return json.loads("".join(input_iter()))