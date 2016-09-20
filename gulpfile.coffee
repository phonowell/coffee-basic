$ = require 'node-jquery-lite'
_ = $._

argv = require('minimist')(process.argv.slice 2)

gulp = require 'gulp'
watch = require 'gulp-watch'
plumber = require 'gulp-plumber'
concat = require 'gulp-concat'
replace = require 'gulp-replace'
using = require 'gulp-using'
rename = require 'gulp-rename'
include = require 'gulp-include'
intercept = require 'gulp-intercept'
changed = require 'gulp-changed'
del = require 'del'

process.on 'uncaughtException', (err) -> $.log err.stack #error

#function

#bind
task = {}
$.task = (name, fn) ->
  gulp.task name, ->
    $.info 'base', "running at #{project.base}"
    task[name]()
  task[name] = fn

#project
project = base: process.cwd()
project.name = project.base.replace /.*\\|.*\//, ''

path =
  source: './source'
  build: './build'

$.task 'watch', ->
  watch "#{path.source}/*.coffee"
  .pipe plumber()
  .pipe changed path.build
  .pipe using()
  .pipe include()
  .pipe intercept (file) ->
    src = './source/module/parse.js'
    delete require.cache[require.resolve src]
    parse = require src

    file.contents = new Buffer parse file.contents.toString()

    file
  .pipe rename (path) ->
    path.extname = '.txt'
    path
  .pipe gulp.dest path.build

$.task 'build', (callback) ->

  del path.build,
    force: true
  .then ->

    gulp.src "#{path.source}/*.coffee"
    .pipe plumber()
    .pipe using()
    .pipe include()
    .pipe intercept (file) ->
      parse = require src
      file.contents = new Buffer parse file.contents.toString()
      file
    .pipe rename (path) ->
      path.extname = '.txt'
      path
    .pipe gulp.dest path.build
    .on 'end', -> callback?()

$.task 'work', -> $.shell 'gulp watch'
$.task 'noop', -> null