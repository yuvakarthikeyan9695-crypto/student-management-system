@echo off
echo Starting local web server at http://127.0.0.1:5500 ...
start http://127.0.0.1:5500/index.html
python -m http.server 5500
