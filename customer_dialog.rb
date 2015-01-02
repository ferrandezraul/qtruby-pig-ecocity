require 'Qt'

class CustomerDialog < Qt::Dialog

  slots 'accept()', 'reject()'

  def initialize( customers_model, parent = nil )
    super( parent )

    self.windowTitle = 'Selecciona el client'

    @label = Qt::Label.new

    # ComboBox
    @combo_box = Qt::ComboBox.new
    #@combo_box.setModel( customers_model )

    c1 = Customer.new( :name => 'Raul',
                  :address => 'Av. Tarragona',
                  :type => 'CLIENT',
                  :nif => '67077877-F')
    c2 = Customer.new( :name => 'carmen',
                       :address => 'Por gava',
                       :type => 'CLIENT',
                       :nif => '67077877-F')

    @combo_box.addItem( c1.name, Qt::Variant.from_value( c1 ) )
    @combo_box.addItem( c2.name, Qt::Variant.from_value( c2 ) )

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

  def get_customer_name
    # Get current Qt::Variant
    #@combo_box.itemData( @combo_box.currentIndex )

    @combo_box.currentText
  end

  def get_customer
    # Get current Qt::Variant
    @combo_box.itemData( @combo_box.currentIndex ).value
  end

end

