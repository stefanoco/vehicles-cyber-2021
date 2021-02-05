# Remark at Bluewind: slides preparation and usage workflow

### Adding new slides sets

  - create a copy of existing markdown and HTML files, with a new name for both
  - modify and add content to the markdown file
  - enjoy the final result by opening the corresponding HTML file in a browser
  - add the new files under git control

```bash
$ cp remark-slides/example.md new_slides.md
$ cp remark-slides/example.html new_slides.html
$ nano new_slides.md
$ firefox new_slides.html
```

### Working on existing slide sets

  - open the relevant markdown file with an editor
  - modify the content using normal markdown sintax with an eye to
    specific meanings for Remark based slides as found in the credits
  - enjoy the final result by opening the corresponding HTML file in a browser

```bash
$ nano existing_slides.md
$ firefox existing_slides.html
```

### Including images in slides

  - copy images to `assets`
  - use normal markdown sintax to include the image in a slide

# Additional tools and operations

### Converting markdown files to PDF

When distributing slides it can be useful to prepare PDF files out of
markdown sources, because printing rendered HTML slides to PDF from the
browser gives strange results.

The best converter found is decktape:

https://github.com/astefanutti/decktape

and a docker image for easy usage of the tool is also available.

Please note that good results are obtained by processind HTML pages
published to a server, so in the following examples Github pages or a very
simple Python local HTTP server are used.

```bash
# Convert all slides to PDF files
# and write them inside pdf folder
# while serving pages on Github
for f in *.html; do \
docker run --rm -v `pwd`:/slides astefanutti/decktape \
https://<username>.github.io/<reponame>/$f pdf/${f%.*}.pdf; done
```

```bash
# Convert all slides to PDF files
# and write them inside pdf folder
# while serving pages on localhost
# (using Python 2)
python -m SimpleHTTPServer&
for f in *.html; do \
docker run --rm --net=host -v `pwd`:/slides astefanutti/decktape \
http://localhost:8000/$f pdf/${f%.*}.pdf; done
```

```bash
# Convert all slides to PDF files
# and write them inside pdf folder
# while serving pages on localhost
# (using Python 3)
python -m http.server&
for f in *.html; do \
docker run --rm --net=host -v `pwd`:/slides astefanutti/decktape \
http://localhost:8000/$f pdf/${f%.*}.pdf; done
```

This latest option is also condensed in a handy bash script found
in this repo:

```bash
./pdfgen.sh
```

### Including images embedded in html / css files

Handy way of including images embedded in css (and html if applicable) files is
preparing base64 version and including the resulting ASCII string.

```bash
$ cat assets/image.png |base64 -w0>b64.txt
```

This is useful while customising the slides template by modifying the
css file:

```bash
$ nano remark-slides/remark-template-bw.css
```

### Credits

- 2021 Stefano Costa, Bluewind
- https://github.com/gnab/remark/wiki
