require 'Qt'

class LineItemsDialog < Qt::Dialog

  slots 'accept()', 'reject()', 'add_product_to_line_items()'

  def initialize( products, customer, parent = nil )
    super( parent )

    @line_items = Array.new

    self.windowTitle = 'Selecciona els productes'

    @customer_label = Qt::Label.new( "#{customer.name}\n#{customer.address}\n#{customer.nif}" )

    @quantity_spin_box = Qt::SpinBox.new

    @weight_spin_box = Qt::DoubleSpinBox.new
    @weight_label = Qt::Label.new( 'Kg' )

    # ComboBox
    @combo_box = Qt::ComboBox.new

    products.each do | product |
      @combo_box.addItem( product.name, Qt::Variant.fromValue( product ) )
    end

    @button_add_item = Qt::PushButton.new( 'Afegir producte' )

    @line_items_view = Qt::PlainTextEdit.new( ' ' )

    @button_box = Qt::DialogButtonBox.new
    @button_box.standardButtons = Qt::DialogButtonBox::Cancel|Qt::DialogButtonBox::Ok

    self.layout = Qt::VBoxLayout.new do |g|
      g.addWidget(@customer_label)
      g.addWidget(@quantity_spin_box)
      g.addWidget(@weight_spin_box)
      g.addWidget(@weight_label)
      g.addWidget(@combo_box)
      g.addWidget(@button_add_item)
      g.addWidget(@line_items_view)
      g.addWidget(@button_box)
    end

    connect(@button_add_item, SIGNAL('clicked()'), self, SLOT('add_product_to_line_items()'))
    connect(@button_box, SIGNAL('accepted()'), self, SLOT('accept()'))
    connect(@button_box, SIGNAL('rejected()'), self, SLOT('reject()'))
  end

  def get_line_items
    @line_items
  end

  def add_product_to_line_items
    Qt::MessageBox::information( self, tr( 'foo' ), "TODO!!" )
  end

end

