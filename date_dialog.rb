require 'Qt'

class DateDialog < Qt::Widget

  slots 'accept()', 'reject()'

  attr_reader :dateEdit

  def initialize( parent = nil )
    super( parent )

    @label = Qt::Label.new

    @dateEdit = Qt::DateEdit.new

    @buttonBox = Qt::DialogButtonBox.new

    @buttonBox.standardButtons = Qt::DialogButtonBox::Cancel|Qt::DialogButtonBox::Ok

    self.layout = Qt::VBoxLayout.new do |g|
      g.addWidget(@label)
      g.addWidget(@dateEdit)
      g.addWidget(@buttonBox)
    end

    connect(@buttonBox, SIGNAL('accepted()'), self, SLOT('accept()'))
    connect(@buttonBox, SIGNAL('rejected()'), self, SLOT('reject()'))
  end

  def accept
    Qt::MessageBox::information( self, tr( 'New order dialog!' ), 'New order')
  end

  def reject
    Qt::MessageBox::information( self, tr( 'New order dialog!' ), 'New order')
  end

end

