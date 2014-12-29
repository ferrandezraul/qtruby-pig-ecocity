require 'Qt'
require './mainwindow.rb'


app = Qt::Application.new(ARGV)
mainWin = MainWindow.new
mainWin.show
app.exec