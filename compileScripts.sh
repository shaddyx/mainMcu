#!/bin/sh

jade html/jade/index.jade -o html --pretty
#jade static/jade/index.jade -o static --pretty
sass --update html/scss/:html/css/ --style compressed