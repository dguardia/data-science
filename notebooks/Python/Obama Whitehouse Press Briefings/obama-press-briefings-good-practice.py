import requests
from os import makedirs
from os.path import join

# fro bama links :  https://obamawhitehouse.archives.gov/briefing-room/press-briefings?page=178

URL_ENDPOINT = 'https://www.whitehouse.gov/briefing-room/press-briefings'
MAX_PAGE_NUM = 178
INDEX_PAGE_DIR = 'index-pages'
makedirs(INDEX_PAGE_DIR, exist_ok=True)

for pagenum in range(0, MAX_PAGE_NUM):
    resp = requests.get(URL_ENDPOINT, params={'page':pagenum})
    print("Downloaded", resp.url)

    fname = join(INDEX_PAGE_DIR, '{pageNumber}.html'.format(pageNumber = pagenum))
    print("Saving to", fname)
    with open(fname, "w") as wf:
        wf.write(resp.text)