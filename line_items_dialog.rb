require 'Qt'

require 'order_item'
require 'product_options_dialog'

class LineItemsDialog < Qt::Dialog
  attr_reader :line_items

  slots 'accept()', 'reject()',
        'add_product_to_line_items()',
        'update_weight_for_index(int)',
        'show_subproducts_for_index(int)'

  def initialize( products, customer, parent = nil )
    super( parent )

    self.windowTitle = 'Selecciona els productes'

    @customer = customer
    @products = products
    @line_items = Array.new

    draw_widgets
  end

  private

  def draw_widgets
    @line_items_label = Qt::Label.new
    @line_items_label.setAlignment( Qt::AlignRight)

    group_box = Qt::GroupBox.new( tr( 'Productes' ) ) do |g|
      g.setLayout( Qt::HBoxLayout.new do |b|
        b.addWidget(@line_items_label)
      end )
    end

    @quantity_spin_box = Qt::SpinBox.new
    button_add_item = Qt::PushButton.new( 'Afegir producte' )
    @weight_spin_box = Qt::DoubleSpinBox.new
    @weight_spin_box.setDecimals( 3 )
    @weight_spin_box.setSuffix( ' kg' )

    # Products ComboBox
    @products_combo_box = Qt::ComboBox.new
    @products.each do | product |
      @products_combo_box.addItem( product.name, Qt::Variant.fromValue( product ) )
    end

    item_layout = Qt::HBoxLayout.new do |b|
      b.addWidget( Qt::Label.new( 'Quantitat:' ) )
      b.addWidget(@quantity_spin_box)
      b.addWidget( Qt::Label.new( 'Pes:' ) )
      b.addWidget(@weight_spin_box)
      b.addWidget(@products_combo_box)
      b.addWidget(button_add_item)
    end

    close_order_buttons = Qt::DialogButtonBox.new
    close_order_buttons.standardButtons = Qt::DialogButtonBox::Cancel|Qt::DialogButtonBox::Ok

    self.layout = Qt::VBoxLayout.new do |g|
      g.addWidget( Qt::Label.new( "#{@customer.name}\n#{@customer.address}\n#{@customer.nif}" ) )
      g.addLayout(item_layout)
      g.addWidget(group_box)
      g.addWidget(close_order_buttons)
    end

    connect(@products_combo_box, SIGNAL('currentIndexChanged(int)'), self, SLOT('show_subproducts_for_index(int)') )
    connect(@products_combo_box, SIGNAL('currentIndexChanged(int)'), self, SLOT('update_weight_for_index(int)') )
    connect(close_order_buttons, SIGNAL('accepted()'), self, SLOT('accept()'))
    connect(close_order_buttons, SIGNAL('rejected()'), self, SLOT('reject()'))
    connect(button_add_item, SIGNAL('clicked()'), self, SLOT('add_product_to_line_items()') )
  end

  # Slot
  def add_product_to_line_items
    product = current_product_from_combobox
    add_product_with_options( product, Array.new )
  end

  # Slot
  def update_weight_for_index( index )
    product = product_from_combobox_index( index )
    if product.weight_per_unit > 0
      @weight_spin_box.setValue( product.weight_per_unit )
    end
  end

  # Slot
  def show_subproducts_for_index( index )
    product = product_from_combobox_index( index )
    if product.has_options?
      options_dialog = ProductOptionsDialog.new( product.options, product.weight_per_unit, self )
      if options_dialog.exec == 1
        options = options_dialog.get_selected_options
        add_product_with_options( product, options )
      end

    end
  end

  def add_product_with_options( product, options )
    # Create OrderItem.new(customer, product, quantity, weight, observations, sub_products)
    order_item = OrderItem.new( @customer, product, @quantity_spin_box.value, @weight_spin_box.value, String.new, options )
    @line_items << order_item
    add_order_item_to_view( order_item )
  end

  def add_order_item_to_view( order_item )
    resume = @line_items_label.text

    if resume
      resume << "\n"
      resume << order_item.to_s
      @line_items_label.setText( resume )
    else
      @line_items_label.setText( order_item.to_s )
    end
  end

  def current_product_from_combobox
    @products_combo_box.itemData( @products_combo_box.currentIndex ).value
  end

  def product_from_combobox_index( index )
    @products_combo_box.itemData( index ).value
  end

end

