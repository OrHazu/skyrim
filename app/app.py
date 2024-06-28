# set up a simple Flask web application that displays a greeting message 
# along with the uptime of the application when accessed through the root URL ("/").

#!/usr/bin/python

import time
from flask import Flask
app = Flask(__name__)

# Snip the current time of the script start
START = time.time()

# difference between the current time (time.time()) and START will be returned here
def elapsed():
    running = time.time() - START
    minutes, seconds = divmod(running, 60)
    hours, minutes = divmod(minutes, 60)
    return "%d:%02d:%02d" % (hours, minutes, seconds)

@app.route('/')
def root():
    return "Hello! (up %s)\n" % elapsed()

if __name__ == "__main__":
    app.run(debug=True, host="0.0.0.0", port=8080)
