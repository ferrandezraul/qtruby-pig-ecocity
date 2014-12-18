require 'Qt4'
require 'qtuitools'

a = Qt::Application.new(ARGV)

# 'ui/date_dialog.ui' was created with qt designer
file = Qt::File.new 'ui/date_dialog.ui' do
  open Qt::File::ReadOnly
end

date_dialog = Qt::UiLoader.new.load file
date_dialog.date_edit.

file.close

if date_dialog.nil?
  print "Error. Window is nil.\n"
  exit
end
date_dialog.show


a.exec