require 'Qt'

require 'order_item'

class LineItemsDialog < Qt::Dialog

  slots 'accept()', 'reject()',
        'add_product_to_line_items()', 'update_weight(int)'

  def initialize( products, customer, parent = nil )
    super( parent )

    self.windowTitle = 'Selecciona els productes'

    @customer = customer

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

    @resume_group_box = Qt::GroupBox.new( tr( 'Productes' ) )
    @line_items_label = Qt::Label.new
    @line_items_label.setAlignment( Qt::AlignRight)

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

    resume_layout = Qt::HBoxLayout.new do |b|
      b.addWidget(@line_items_label)
    end

    @resume_group_box.layout = resume_layout

    self.layout = Qt::VBoxLayout.new do |g|
      g.addWidget(@customer_label)
      g.addLayout(item_layout)
      g.addWidget(@resume_group_box)
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

    product = @combo_box.itemData( @combo_box.currentIndex ).value

    # Create OrderItem.new(customer, product, quantity, weight, observations, sub_products)
    order_item = OrderItem.new( @customer, product, @quantity_spin_box.value, @weight_spin_box.value, String.new, Array.new )

    resume = @line_items_label.text

    if resume
      resume << "\n"
      resume << order_item.to_s
      @line_items_label.setText( resume )
    else
      @line_items_label.setText( order_item.to_s )
    end

  end

  def update_weight( index )
    product = @combo_box.itemData( index ).value
    if product.weight_per_unit > 0
      @weight_spin_box.setValue( product.weight_per_unit )
    end
  end

end

