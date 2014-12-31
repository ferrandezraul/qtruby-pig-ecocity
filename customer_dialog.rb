require 'Qt'

class CustomerDialog < Qt::Dialog

  slots 'accept()', 'reject()'

  attr_reader :dateEdit

  def initialize( customers, parent = nil )
    super( parent )

    self.windowTitle = 'Selecciona el client'

    @label = Qt::Label.new

    # ComboBox

    @button_box = Qt::DialogButtonBox.new
    @button_box.standardButtons = Qt::DialogButtonBox::Cancel|Qt::DialogButtonBox::Ok

    self.layout = Qt::VBoxLayout.new do |g|
      g.addWidget(@label)

      g.addWidget(@button_box)
    end

    connect(@button_box, SIGNAL('accepted()'), self, SLOT('accept()'))
    connect(@button_box, SIGNAL('rejected()'), self, SLOT('reject()'))
  end

  def get_customer
    # Return customer
  end

end

