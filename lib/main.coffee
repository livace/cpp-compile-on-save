child_process = require('child_process')

compile = (event) ->
  file = event.path # compiling file

  if file.split('.').pop() isnt 'cpp'
    return # check file ext

  command = atom.config.get('cpp-compile-on-save.compileCommand')

  compiledPath = file.replace(/.cpp$/, '')

  options = (file + ' -o ' + compiledPath + ' ' + atom.config.get('cpp-compile-on-save.compilerOptions').replace( /\s\s+/g, ' ' ).trim() ).split(' ')

  child_process.spawn(command, options)

module.exports =
  activate: () ->
    atom.workspace.observeTextEditors (editor) ->
      editor.onDidSave(compile)
  config:
    compileCommand:
      default: 'g++',
      title: 'Compile command',
      type: 'string'
    compilerOptions:
      default: '-O2 -std=c++14',
      description: 'Compiler command line options',
      title: 'Compiler options',
      type: 'string'
