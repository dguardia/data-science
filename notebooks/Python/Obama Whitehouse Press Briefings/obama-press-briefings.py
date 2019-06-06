import requests

url = 'https://obamawhitehouse.archives.gov/briefing-room/press-briefings?page=0'

resp = requests.get(url)

with open("./data/0.html", "w") as wf:
    wf.write(resp.text)


