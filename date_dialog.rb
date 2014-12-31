require 'Qt'

class DateDialog < Qt::Dialog

  slots 'accept()', 'reject()'

  attr_reader :date_edit

  def initialize( parent = nil )
    super( parent )

    self.windowTitle = 'Selecciona la data'

    @label = Qt::Label.new( tr( 'Selecciona la data de la comanda' ))

    @date_edit = Qt::DateEdit.new( Qt::Date::currentDate)
    @date_edit.calendarPopup = true

    @button_box = Qt::DialogButtonBox.new

    @button_box.standardButtons = Qt::DialogButtonBox::Cancel|Qt::DialogButtonBox::Ok

    self.layout = Qt::VBoxLayout.new do |g|
      g.addWidget(@label)
      g.addWidget(@date_edit)
      g.addWidget(@button_box)
    end

    connect(@button_box, SIGNAL('accepted()'), self, SLOT('accept()'))
    connect(@button_box, SIGNAL('rejected()'), self, SLOT('reject()'))
  end

  def get_date
    @date_edit.date
  end

end

