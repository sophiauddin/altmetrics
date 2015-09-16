## Writing in Markdown
#Acts as a lab notebook; can share it with PI, collaborators, etc.
#Markdown is a language that writes nice-looking text and gets rendered into html
#Don't need to render it to understand it! (benefit over html)

#to install
install.packages("rmarkdown")
installed.packages("rmarkdown") #check if installed

#Open a text file; type stuff.
#Save as filename.md, which stands for markdown. You can then preview html
#using the available button.

#Enter 2 spaces at the end of a line to make sure that the NEXT line appears on a new line.
#Enter a blank line to put a space between paragraphs

#Bullet list: put *, +, or - in front of things makes them bullet points.

#Note: previewing saves it!

#Bold **text**
#Italic _text_

#putting code into markdown: type a backtick (under the ~): `codestuff
#putting a code block: ```code blah blah ```

#Putting hyperlinks into markdown:
#1. Inline: [text to be link](URL)
#2.Reference-style linking: [text in question][text of link e.g. 1 or link1]
#then later in document, put:
#[link1]: http://url, etc. (see README.md for an example)

#Adding headers: more hashtags to make it smaller!

## Writing in R markdown, specifically!
#File > new > R markdown
#Note that you can change the output type in the header at the top
#R Markdown includes chunks: indicated by 
# ```{r}
#summary(cars)
#```
#This will actually run the code and show output!!
#To render, click "Knit" and save as filename.Rmd
#Ctrl+Option+I = insert a new chunk

#To name a chunk (in case script is long): ```{r chunkname}

#Look on R Markdown tab for troubleshooting if a chunk is taking a long time

#Option: echo=FALSE as an option: ```{r chunkname, echo=FALSE}
#Will show output but not code
#Good for embedding plots

#Can also display code but not show results: ```{r chunkname, results="hide"}

#To do something entirely in background and not display code OR results:
#```{r chunkname, include=FALSE}

#Ctrl+option+c = run whole chunk
#Ctrl+return = run a line

#Auto-updating a displayed number:
# `r command ` (see example)
# The number of cars is `r dim(cars)[1]`

#Adding a table of contents:
#output:
#    html_document:
#      toc: true
#      number_sections: true (otherwise will be bullet points)
#      theme: look up online
#      highlight: look up also; makes code stand out
#      fig_width: number (will read in inches) figures default to 5x7 inches
#      fig_height: number in inches
#      fig_caption: yes (include figure captions)

#to caption a figure: {r chunkname, fig.cap="text of figure caption"}

#Default: self-contained means that only html is spit out afterwards
#In header area, put
#      self_contained: false
#Saves all the ancillary files that get created during running in a new folder

#To knit from command line (e.g. on a cluster):
library("rmarkdown") #load the library
render("altmetrics_analyses.Rmd")

#Will save a file, not pop anything up. Look for the html file.

#To knit to pdf and word: look to see what you need to install (PDF)
#To knit to word: dropdown menu --> knit to word