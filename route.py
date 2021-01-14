from app import app,  request

import controller


@app.route('/', methods = ['POST', 'GET'])
def home():
    if request.method == 'GET': 
     result = controller.returnget()
    elif request.method == 'POST': 
      result = controller.notrunning()
    return result
       


    
@app.route('/create', methods = ['POST', 'GET'])
def create(): 
    if request.method == 'GET': 
     result = controller.returnget()
    elif request.method == 'POST': 
        result = controller.create()
    return result



@app.route('/delete', methods = ['POST', 'GET'])
def delete(): 
    if request.method == 'GET': 
     result = controller.returnget()
    elif request.method == 'POST': 
        result = controller.delete()
    return result
