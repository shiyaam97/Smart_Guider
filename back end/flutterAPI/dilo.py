import nltk
from nltk import tokenize
from operator import itemgetter
import math
from nltk.corpus import stopwords



def dilo(a,b):
    print(a)
    print(b)
    f = open(a, 'r')

    data = f.read()
    splat = data.split('\n\n')
    scheme = []
    for number, paragraph in enumerate(splat, 1):
        # print(paragraph)
        scheme.append(paragraph)
    print(scheme)
    print(len(scheme))

    f = open(b, 'r')

    data = f.read()
    splat = data.split('\n\n')
    answers = []
    for number, paragraph in enumerate(splat, 1):
        # print(paragraph)
        answers.append(paragraph)
    print(answers)
    print(len(answers))

    # q1="Cellular_respiration, the process by which organisms Cellular_respiration combine oxygen with foodstuff molecules, diverting  Cellular_respiration the chemical energy in these Cellular_respiration substances into life-sustaining activities and discarding, as waste products, carbon dioxide and water. Organisms that do not depend on oxygen degrade foodstuffs in a process called fermentation. (For longer treatments of various aspects of cellular respiration, see tricarboxylic acid cycle."


    nltk.download('punkt')
    nltk.download('stopwords')
    from nltk.tokenize import word_tokenize
    from nltk.tokenize import sent_tokenize
    stop_words = set(stopwords.words('english'))

    def key_extract(a):
        # Find the total number of words
        total_words = a.split()
        total_word_length = len(total_words)
        print(total_word_length)

        # Find the total number sentences
        total_sentences = tokenize.sent_tokenize(a)
        total_sentence_length = len(total_sentences)
        print(total_sentence_length)

        # tf_score={'Cellular_res':2/30,'prrocess':1/30,'srafa':5}
        tf_score = {}
        for each_word in total_words:
            each_word = each_word.replace('.', '')
            if each_word not in stop_words:
                if each_word in tf_score:
                    tf_score[each_word] += 1
                else:
                    tf_score[each_word] = 1

        # Dividing by total_word_length for each dictionary element
        tf_score.update((x, y / int(total_word_length)) for x, y in tf_score.items())
        print(tf_score)

        def check_sentences(word, sentences):
            final = [all([w in x for w in word]) for x in sentences]
            sent_len = [sentences[i] for i in range(0, len(final)) if final[i]]
            return int(len(sent_len))

        idf_score = {}
        for each_word in total_words:
            each_word = each_word.replace('.', '')
            if each_word not in stop_words:
                if each_word in idf_score:
                    idf_score[each_word] = check_sentences(each_word, total_sentences)
                else:
                    idf_score[each_word] = 1
        # idf_score={'Cellular_res':log(3/20),'prrocess':3/30,'srafa':3/50}

        # Performing a log and divide
        idf_score.update((x, math.log(int(total_sentence_length) / y)) for x, y in idf_score.items())

        print(idf_score)

        # tf_idf_score.keys()={'cellular','process'}
        # tf_idf_score=['cellular':2/30,*log(3/20),'process':x1*y1, 'sasafa']
        tf_idf_score = {key: tf_score[key] * idf_score.get(key, 0) for key in tf_score.keys()}
        print(tf_idf_score)

        def top_words(dictionary, n):
            result = dict(sorted(dictionary.items(), key=itemgetter(1), reverse=True)[:n])
            return result

        return top_words(tf_idf_score, 5)

    # key_extract(q1)

    # Creating list with all the keywords with percentage order of every paragraphs in scheme
    lst3 = []
    for i in scheme:
        lst3.append(key_extract(i))
    print(lst3)

    # Creating list with all the keywords with percentage order of every paragraphs in answers
    lst4 = []
    for i in answers:
        lst4.append(key_extract(i))
    print(lst4)

    # Creating list with only keywords in scheme, and answers
    lst1 = []
    lst2 = []
    for i in lst3:
        for key in i:
            lst1.append(key)
    for i in lst4:
        for key in i:
            lst2.append(key)
    print(lst1)
    print(lst2)

    # Creating dictionaries to filter the keywords of each sentences in to a list for each sentences scheme, and answers
    dict9 = {}
    i = 0
    for j in lst2:
        dict9[j] = lst2[i:i + 5]
        i = i + 5
    print(dict9)

    dict10 = {}
    i = 0
    for j in lst1:
        dict10[j] = lst1[i:i + 5]
        i = i + 5
    print(dict10)

    list_with_keywords_for_scheme = []
    list_with_keywords_for_answers = []
    for k in dict9.values():
        list_with_keywords_for_scheme.append(k)
    for k in dict10.values():
        list_with_keywords_for_answers.append(k)
    print(list_with_keywords_for_scheme)
    print(list_with_keywords_for_answers)

    def compare_score(list1, list2):
        similarity = len(set(list1) & set(list2)) / float(len(set(list1) | set(list2))) * 100
        print("Similarity percentage : " + str(similarity))
        return similarity

    print(list_with_keywords_for_scheme[3])
    print(list_with_keywords_for_answers[3])
    compare_score(list_with_keywords_for_scheme[3], list_with_keywords_for_answers[3])

    score = []
    for i in range(len(list_with_keywords_for_scheme)):
        try:
            score.append(compare_score(list_with_keywords_for_scheme[i], list_with_keywords_for_answers[i]))
        except ZeroDivisionError as e:
            continue
    print(score)

    sum = 0
    for i in score:
        sum = sum + i
    average = sum / len(score)
    print(average)

    if average < 35:
        p = 'Fail'
        print('Fail')
    elif 35 < average < 50:
        p = 'D'
        print('D')
    elif 50 < average < 65:
        p = 'C'
        print("C")
    elif 65 < average < 75:
        p = 'B'
        print("B")
    elif 75 < average <= 100:
        p = 'A'
        print("A")

    d = {}
    d['output'] = p
    return d

