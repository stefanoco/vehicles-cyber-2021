#!/bin/bash
# Convert all slides to PDF files
# and write them inside pdf folder
# while serving pages on localhost
( python3 -m http.server ) & 
for f in *.html; do
  docker run --rm --net=host -v `pwd`:/slides astefanutti/decktape http://localhost:8000/$f pdf/${f%.*}.pdf
done
# kill sub processes (Python simple HTTP server)
pkill -P $$
