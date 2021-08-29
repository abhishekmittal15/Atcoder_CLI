#%%
import requests

url="https://atcoder.jp/contests/abc216/tasks"
res=requests.get(url)
print(res.text)