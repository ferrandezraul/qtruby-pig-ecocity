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

    @line_items = Array.new

    @customer_label = Qt::Label.new( "#{customer.name}\n#{customer.address}\n#{customer.nif}" )

    @quantity_label = Qt::Label.new( 'Quantitat:' )
    @quantity_spin_box = Qt::SpinBox.new

    @weight_label = Qt::Label.new( 'Pes:' )
    @weight_spin_box = Qt::DoubleSpinBox.new
    @weight_spin_box.setDecimals( 3 )
    @weight_spin_box.setSuffix( ' kg' )

    # Products ComboBox
    @products_combo_box = Qt::ComboBox.new
    products.each do | product |
      @products_combo_box.addItem( product.name, Qt::Variant.fromValue( product ) )
    end

    @button_add_item = Qt::PushButton.new( 'Afegir producte' )

    @resume_group_box = Qt::GroupBox.new( tr( 'Productes' ) )
    @line_items_label = Qt::Label.new
    @line_items_label.setAlignment( Qt::AlignRight)

    @button_box = Qt::DialogButtonBox.new
    @button_box.standardButtons = Qt::DialogButtonBox::Cancel|Qt::DialogButtonBox::Ok

    draw_widgets

    connect(@products_combo_box, SIGNAL('currentIndexChanged(int)'), self, SLOT('show_subproducts_for_index(int)') )
    connect(@products_combo_box, SIGNAL('currentIndexChanged(int)'), self, SLOT('update_weight_for_index(int)') )
    connect(@button_box, SIGNAL('accepted()'), self, SLOT('accept()'))
    connect(@button_box, SIGNAL('rejected()'), self, SLOT('reject()'))
    connect(@button_add_item, SIGNAL('clicked()'), self, SLOT('add_product_to_line_items()'))
  end

  private

  def draw_widgets
    item_layout = Qt::HBoxLayout.new do |b|
      b.addWidget(@quantity_label)
      b.addWidget(@quantity_spin_box)
      b.addWidget(@weight_label)
      b.addWidget(@weight_spin_box)
      b.addWidget(@products_combo_box)
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
  end

  # Slot
  def add_product_to_line_items
    product = @products_combo_box.itemData( @products_combo_box.currentIndex ).value
    add_product_with_options( product, Array.new )
  end

  # Slot
  def update_weight_for_index( index )
    product = @products_combo_box.itemData( index ).value
    if product.weight_per_unit > 0
      @weight_spin_box.setValue( product.weight_per_unit )
    end
  end

  # Slot
  def show_subproducts_for_index( index )
    product = @products_combo_box.itemData( index ).value
    if product.has_options?
      options_dialog = ProductOptionsDialog.new( product.options, product.weight_per_unit, self )
      if options_dialog.exec == 1
        options = options_dialog.get_selected_options
        product = @products_combo_box.itemData( @products_combo_box.currentIndex ).value

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

end

