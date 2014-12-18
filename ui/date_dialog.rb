=begin
** Form generated from reading ui file 'date_dialog.ui'
**
** Created: jue dic 18 16:25:11 2014
**      by: Qt User Interface Compiler version 4.8.6
**
** WARNING! All changes made in this file will be lost when recompiling ui file!
=end

require 'Qt4'

class Ui_Dialog
    attr_reader :verticalLayout_2
    attr_reader :verticalLayout
    attr_reader :label_2
    attr_reader :horizontalLayout
    attr_reader :label
    attr_reader :dateEdit
    attr_reader :buttonBox

    def setupUi(dialog)
    if dialog.objectName.nil?
        dialog.objectName = "dialog"
    end
    dialog.resize(400, 179)
    @verticalLayout_2 = Qt::VBoxLayout.new(dialog)
    @verticalLayout_2.objectName = "verticalLayout_2"
    @verticalLayout = Qt::VBoxLayout.new()
    @verticalLayout.objectName = "verticalLayout"
    @label_2 = Qt::Label.new(dialog)
    @label_2.objectName = "label_2"
    @font = Qt::Font.new
    @font.bold = true
    @font.weight = 75
    @label_2.font = @font
    @label_2.alignment = Qt::AlignCenter

    @verticalLayout.addWidget(@label_2)

    @horizontalLayout = Qt::HBoxLayout.new()
    @horizontalLayout.objectName = "horizontalLayout"
    @label = Qt::Label.new(dialog)
    @label.objectName = "label"
    @label.alignment = Qt::AlignRight|Qt::AlignTrailing|Qt::AlignVCenter

    @horizontalLayout.addWidget(@label)

    @dateEdit = Qt::DateEdit.new(dialog)
    @dateEdit.objectName = "dateEdit"

    @horizontalLayout.addWidget(@dateEdit)


    @verticalLayout.addLayout(@horizontalLayout)

    @buttonBox = Qt::DialogButtonBox.new(dialog)
    @buttonBox.objectName = "buttonBox"
    @buttonBox.orientation = Qt::Horizontal
    @buttonBox.standardButtons = Qt::DialogButtonBox::Cancel|Qt::DialogButtonBox::Ok

    @verticalLayout.addWidget(@buttonBox)


    @verticalLayout_2.addLayout(@verticalLayout)


    retranslateUi(dialog)
    Qt::Object.connect(@buttonBox, SIGNAL('accepted()'), dialog, SLOT('accept()'))
    Qt::Object.connect(@buttonBox, SIGNAL('rejected()'), dialog, SLOT('reject()'))

    Qt::MetaObject.connectSlotsByName(dialog)
    end # setupUi

    def setup_ui(dialog)
        setupUi(dialog)
    end

    def retranslateUi(dialog)
    dialog.windowTitle = Qt::Application.translate("Dialog", "Dialog", nil, Qt::Application::UnicodeUTF8)
    @label_2.text = Qt::Application.translate("Dialog", "Selecciona la data de la comanda", nil, Qt::Application::UnicodeUTF8)
    @label.text = Qt::Application.translate("Dialog", "Data:", nil, Qt::Application::UnicodeUTF8)
    end # retranslateUi

    def retranslate_ui(dialog)
        retranslateUi(dialog)
    end

end

module Ui
    class Dialog < Ui_Dialog
    end
end  # module Ui

if $0 == __FILE__
    a = Qt::Application.new(ARGV)
    u = Ui_Dialog.new
    w = Qt::Dialog.new
    u.setupUi(w)
    w.show
    a.exec
end
