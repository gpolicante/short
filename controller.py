import bitly_api
from flask import Flask, redirect, url_for, request
import requests
import urllib2
import os 
def returnget(): 

    return "only api with method POST"

def notrunning(): 

    return "the endpoints to some action are /create and /delete"

def input():
    
   try:
    uri = request.data
    
    consult = "http" in uri 
    if consult == True: 
        result = request.data
        contents = urllib2.urlopen(result).read()
    else:
       
       result = "http://" + uri
       contents = urllib2.urlopen(result).read()
    return result
   except: 
       return "deu ruim"

def create(): 

  try:  
    TOKEN = os.environ['TOKEN']
    BITLY_ACCESS_TOKEN = TOKEN
    access = bitly_api.Connection(access_token = BITLY_ACCESS_TOKEN)
    full_link = input()
    short_url = access.shorten(full_link)
    result = short_url['url']
    return result 
  except:
      full_link = input()
      return " URL not running, return url 4XXX or 5XX"

def delete(): 
    try:   
       session = requests.Session()
       resp = session.head(input(), allow_redirects=True)

       return resp.url
    except:
        url = input()
        return "URL not running, return url 4XXX or 5XX"