import requests

THE_URL = 'https://www.whitehouse.gov/briefing-room/press-briefings?page='

MAX_NUM_PAGES = 178

for pagenum in range(0, MAX_NUM_PAGES):
    url = THE_URL + str(pagenum)
    print('Dowonloading', url)
    resp = requests.get(url)
    data_folder = 'data/'
    file_name = data_folder + str(pagenum) + '.html'
    print("Saving to", file_name)
    with open(file_name, "w") as wf:
        wf.write(resp.text)