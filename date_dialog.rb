require 'Qt'

class DateDialog < Qt::Widget

    slots 'accept()', 'reject()'

    attr_reader :verticalLayout_2
    attr_reader :verticalLayout
    attr_reader :label_2
    attr_reader :horizontalLayout
    attr_reader :label
    attr_reader :dateEdit
    attr_reader :buttonBox

    def initialize( parent = nil )
      super( parent )

      @verticalLayout_2 = Qt::VBoxLayout.new( parent )

      @verticalLayout_2.objectName = "verticalLayout_2"

      @verticalLayout = Qt::VBoxLayout.new()

      @verticalLayout.objectName = "verticalLayout"
      @label_2 = Qt::Label.new( parent )
      @label_2.objectName = "label_2"
      @font = Qt::Font.new
      @font.bold = true
      @font.weight = 75
      @label_2.font = @font
      @label_2.alignment = Qt::AlignCenter

      @verticalLayout.addWidget(@label_2)

      @horizontalLayout = Qt::HBoxLayout.new()
      @horizontalLayout.objectName = "horizontalLayout"
      @label = Qt::Label.new( parent )
      @label.objectName = "label"
      @label.alignment = Qt::AlignRight|Qt::AlignTrailing|Qt::AlignVCenter

      @horizontalLayout.addWidget(@label)

      @dateEdit = Qt::DateEdit.new(parent)
      @dateEdit.objectName = "dateEdit"

      @horizontalLayout.addWidget(@dateEdit)


      @verticalLayout.addLayout(@horizontalLayout)

      @buttonBox = Qt::DialogButtonBox.new(parent)
      @buttonBox.objectName = "buttonBox"
      @buttonBox.orientation = Qt::Horizontal
      @buttonBox.standardButtons = Qt::DialogButtonBox::Cancel|Qt::DialogButtonBox::Ok

      @verticalLayout.addWidget(@buttonBox)

      @verticalLayout_2.addLayout(@verticalLayout)

      connect(@buttonBox, SIGNAL('accepted()'), self, SLOT('accept()'))
      connect(@buttonBox, SIGNAL('rejected()'), self, SLOT('reject()'))
    end

end

