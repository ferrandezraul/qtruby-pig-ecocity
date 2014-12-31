require 'Qt'

class CustomerDialog < Qt::Dialog

  slots 'accept()', 'reject()'

  def initialize( customers_model, parent = nil )
    super( parent )

    self.windowTitle = 'Selecciona el client'

    @label = Qt::Label.new

    # ComboBox
    @combo_box = Qt::ComboBox.new
    @combo_box.setModel( customers_model )

    @button_box = Qt::DialogButtonBox.new
    @button_box.standardButtons = Qt::DialogButtonBox::Cancel|Qt::DialogButtonBox::Ok

    self.layout = Qt::VBoxLayout.new do |g|
      g.addWidget(@label)
      g.addWidget(@combo_box)
      g.addWidget(@button_box)
    end

    connect(@button_box, SIGNAL('accepted()'), self, SLOT('accept()'))
    connect(@button_box, SIGNAL('rejected()'), self, SLOT('reject()'))
  end

  def get_customer
    #@combo_box.itemData( @combo_box.currentIndex )
    @combo_box.currentText
  end

end

