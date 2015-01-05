require 'orders_model'

require 'order'
require 'ap'
require 'date'

require 'new_order_dialog'

class OrdersTab < Qt::Widget

  slots 'new_order()'

  def initialize( products, customers, orders_model, parent = nil )
    super(parent)

    @customers = customers
    @products = products
    @orders_model = orders_model

    button = Qt::PushButton.new( tr( 'Nova comanda' ) )
    orders_tree_view = Qt::TreeView.new
    orders_tree_view.setAlternatingRowColors( true )
    orders_tree_view.model = @orders_model
    orders_tree_view.windowTitle = 'Orders Tree Model'
    orders_tree_view.show

    h_layout = Qt::HBoxLayout.new do |m|
      m.addWidget( button )
      # Add spacer
      m.addStretch( 1 )
    end

    self.layout = Qt::VBoxLayout.new do |m|
      m.addLayout( h_layout )
      m.addWidget( orders_tree_view )
    end

    connect( button, SIGNAL( 'clicked()' ), self, SLOT( 'new_order()' ) )

  end

  def new_order
    order_dialog = NewOrderDialog.new( @products, @customers, self )

    qdate = order_dialog.date
    customer = order_dialog.customer
    line_items = order_dialog.line_items

    if qdate && customer && line_items.any?
      date = Date.new( qdate.year, qdate.month, qdate.day )

      order = Order.new( customer, date, line_items )
      OrdersModel.add_order_to_model( order, @orders_model )
    end
  end

end