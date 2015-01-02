require 'Qt'

class LineItemsDialog < Qt::Dialog

  slots 'accept()', 'reject()',
        'add_product_to_line_items()', 'update_weight(int)'

  def initialize( products, customer, parent = nil )
    super( parent )

    self.windowTitle = 'Selecciona els productes'

    @line_items = Array.new

    @customer_label = Qt::Label.new( "#{customer.name}\n#{customer.address}\n#{customer.nif}" )

    @quantity_label = Qt::Label.new( 'Quantitat:' )
    @quantity_spin_box = Qt::SpinBox.new

    @weight_label = Qt::Label.new( 'Pes:' )
    @weight_spin_box = Qt::DoubleSpinBox.new
    @weight_spin_box.setDecimals( 3 )
    @weight_spin_box.setSuffix( ' kg' )

    # Products ComboBox
    @combo_box = Qt::ComboBox.new
    products.each do | product |
      @combo_box.addItem( product.name, Qt::Variant.fromValue( product ) )
    end

    @button_add_item = Qt::PushButton.new( 'Afegir producte' )

    @line_items_view = Qt::PlainTextEdit.new( String.new )

    @button_box = Qt::DialogButtonBox.new
    @button_box.standardButtons = Qt::DialogButtonBox::Cancel|Qt::DialogButtonBox::Ok

    item_layout = Qt::HBoxLayout.new do |b|
      b.addWidget(@quantity_label)
      b.addWidget(@quantity_spin_box)
      b.addWidget(@weight_label)
      b.addWidget(@weight_spin_box)
      b.addWidget(@combo_box)
      b.addWidget(@button_add_item)
    end

    self.layout = Qt::VBoxLayout.new do |g|
      g.addWidget(@customer_label)
      g.addLayout(item_layout)
      g.addWidget(@line_items_view)
      g.addWidget(@button_box)
    end

    connect(@button_add_item, SIGNAL('clicked()'), self, SLOT('add_product_to_line_items()'))
    connect(@button_box, SIGNAL('accepted()'), self, SLOT('accept()'))
    connect(@button_box, SIGNAL('rejected()'), self, SLOT('reject()'))
    connect(@combo_box, SIGNAL('currentIndexChanged(int)'), self, SLOT('update_weight(int)') )
  end

  def get_line_items
    @line_items
  end

  def add_product_to_line_items
    Qt::MessageBox::information( self, tr( 'foo' ), "TODO!!" )
  end

  def update_weight( index )
    product = @combo_box.itemData( index ).value
    if product.weight_per_unit > 0
      @weight_spin_box.setValue( product.weight_per_unit )
    end
  end

end

