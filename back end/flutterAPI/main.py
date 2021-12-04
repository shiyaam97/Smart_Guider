
import werkzeug
from flask import Flask, request, jsonify
import numpy as np

from dilo import dilo
import pickle
import nltk
nltk.download('popular')

from nltk.stem import WordNetLemmatizer
lemmatizer = WordNetLemmatizer()
import pickle
import numpy as np

from keras.models import load_model
model = load_model('model.h5')
import json
import random

intents = json.loads(open('data.json').read())
words = pickle.load(open('texts.pkl','rb'))
classes = pickle.load(open('labels.pkl','rb'))
image_location = ''
teacherLocation = ''
studentLocation = ''


def clean_up_sentence(sentence):
    # tokenize the pattern - split words into array
    sentence_words = nltk.word_tokenize(sentence)
    # stem each word - create short form for word
    sentence_words = [lemmatizer.lemmatize(word.lower()) for word in sentence_words]
    return sentence_words

# return bag of words array: 0 or 1 for each word in the bag that exists in the sentence

def bow(sentence, words, show_details=True):
    # tokenize the pattern
    sentence_words = clean_up_sentence(sentence)
    # bag of words - matrix of N words, vocabulary matrix
    bag = [0]*len(words)
    for s in sentence_words:
        for i,w in enumerate(words):
            if w == s:
                # assign 1 if current word is in the vocabulary position
                bag[i] = 1
                if show_details:
                    print ("found in bag: %s" % w)
    return(np.array(bag))

def predict_class(sentence, model):
    # filter out predictions below a threshold
    p = bow(sentence, words,show_details=False)
    res = model.predict(np.array([p]))[0]
    ERROR_THRESHOLD = 0.25
    results = [[i,r] for i,r in enumerate(res) if r>ERROR_THRESHOLD]
    # sort by strength of probability
    results.sort(key=lambda x: x[1], reverse=True)
    return_list = []
    for r in results:
        return_list.append({"intent": classes[r[0]], "probability": str(r[1])})
    return return_list

def getResponse(ints, intents_json):
    tag = ints[0]['intent']
    list_of_intents = intents_json['intents']
    for i in list_of_intents:
        if(i['tag']== tag):
            result = random.choice(i['responses'])
            break
    return result

def ibot_response(msg):
    ints = predict_class(msg, model)
    res = getResponse(ints, intents)
    print(res)
    d = {}
    d['output'] = res
    return d


app = Flask(__name__)

@app.route("/get")
def get_bot_response():
    userText = request.args.get('msg')
    return ibot_response(userText)

@app.route('/upload', methods=["POST"])
def upload():
    global studentLocation
    global teacherLocation
    if request.method == "POST":
        print(request.values['test'])
        fileone = request.files['image']
        filename = werkzeug.utils.secure_filename(fileone.filename)
        loc ="./uploadfiles/"+ request.values['test'] +"/" + filename
        if(request.values['test'] == 'teacher'):
            teacherLocation = loc
        else:
            studentLocation = loc


        image_location = "./uploadfiles/"+ request.values['test'] +"/" + filename
        print("\nReceived image File name : " + fileone.filename)
        fileone.save("./uploadfiles/"+ request.values['test'] +"/" + filename)

        return jsonify({
            "message": image_location,
        })
@app.route('/api', methods = ['GET'])
def returnascii():

    d = request.args['query']
    arr1 = d.strip("[").strip("]").split(", ")
    ints = arr1
    print("arr")
    print(arr1)
    string_ints = [str(int) for int in ints]
    str_of_ints = "".join(string_ints)
    print(str_of_ints.split(" "))



    model1 = pickle.load(open('GoodWeak.pickle', 'rb'))
    model2 = pickle.load(open('Performance_range_01.pickle', 'rb'))

    print(arr1)
    arr = np.array([arr1])

    print(arr)
    pred = model1.predict(arr)
    print(pred[0])

    print("finish")
    f1arr = arr1.append(str(pred[0]))
    print(arr1)
    print("nnn")
    arr2 = np.array([arr1])

    pred2 = model2.predict(arr2)
    print(pred2)

    f = '10'

    if pred == [0]:
        c = 'Weak'
    elif pred == [1]:
        c = 'Good'
    else:
        c = ''

    if pred2 == [0]:
        f = '0-40'
    elif pred2 == [1]:
        f = '40-50'
    elif pred2 == [2]:
        f = '50-65'
    elif pred2 == [3]:
        f = '65-75'
    elif pred2 == [4]:
        f = '75-100'

    d = {}
    d['perfromance'] = c, f
    print(d)
    return d



@app.route('/member2', methods = ['GET'])
def member2():
    global  teacherLocation
    global  studentLocation
    return dilo(teacherLocation,studentLocation)



if __name__ == "__main__":
    app.run(port=5001, debug=True,host='0.0.0.0')