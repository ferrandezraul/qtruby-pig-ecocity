require 'Qt'

class CustomerDialog < Qt::Dialog

  slots 'accept()', 'reject()'

  def initialize( customers, parent = nil )
    super( parent )

    self.windowTitle = 'Selecciona el client'

    # ComboBox
    @combo_box = Qt::ComboBox.new
    #@combo_box.setModel( customers_model )

    customers.each do | customer |
      @combo_box.addItem( customer.name, Qt::Variant.from_value( customer ) )
    end

    @button_box = Qt::DialogButtonBox.new
    @button_box.standardButtons = Qt::DialogButtonBox::Cancel|Qt::DialogButtonBox::Ok

    self.layout = Qt::VBoxLayout.new do |g|
      g.addWidget(@combo_box)
      g.addWidget(@button_box)
    end

    connect(@button_box, SIGNAL('accepted()'), self, SLOT('accept()'))
    connect(@button_box, SIGNAL('rejected()'), self, SLOT('reject()'))
  end

  def get_customer
    # Get current Qt::Variant
    @combo_box.itemData( @combo_box.currentIndex ).value
  end

end

