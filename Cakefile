fs      = require 'fs'
{print} = require 'sys'
{spawn} = require 'child_process'

build = (watch, callback) ->
  if typeof watch is 'function'
    callback = watch
    watch = false
  options = ['-c', '-o', 'lib', 'src']
  options.unshift '-w' if watch

  coffee = spawn 'coffee', options
  coffee.stdout.on 'data', (data) -> print data.toString()
  coffee.stderr.on 'data', (data) -> print data.toString()
  coffee.on 'exit', (status) -> callback?() if status is 0

task 'build', 'Compile CoffeeScript source files', ->
  build()

task 'watch', 'Recompile CoffeeScript source files when modified', ->
  build true

task 'start', 'Wake up Carl', ->
  build ->
    server = spawn 'node', ['./lib/server.js']
    server.stdout.on 'data', (data) -> print data.toString()
    server.stderr.on 'data', (data) -> print data.toString()
    process.on 'SIGINT', -> server.kill('SIGQUIT')
