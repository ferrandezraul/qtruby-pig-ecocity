require 'Qt'

class LineItemsDialog < Qt::Dialog

  slots 'accept()', 'reject()'

  def initialize( products_model, customer, parent = nil )
    super( parent )

    @line_items = Array.new

    self.windowTitle = 'Selecciona el productes'

    @customer_label = Qt::Label.new( "#{customer.name}\n#{customer.address}\n#{customer.nif}" )

    # ComboBox
    @combo_box = Qt::ComboBox.new
    @combo_box.setModel( products_model )

    @line_items_view = Qt::TextField.new

    @button_box = Qt::DialogButtonBox.new
    @button_box.standardButtons = Qt::DialogButtonBox::Cancel|Qt::DialogButtonBox::Ok

    self.layout = Qt::VBoxLayout.new do |g|
      g.addWidget(@customer_label)
      g.addWidget(@combo_box)
      g.addWidget(@button_box)
      g.addWidget(@line_items_view)
    end

    connect(@button_box, SIGNAL('accepted()'), self, SLOT('accept()'))
    connect(@button_box, SIGNAL('rejected()'), self, SLOT('reject()'))
  end

  def get_line_items
    @line_items
  end

end

