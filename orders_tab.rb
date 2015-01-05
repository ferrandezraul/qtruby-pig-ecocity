require 'date_dialog'
require 'customer_dialog'
require 'line_items_dialog'
require 'orders_model'

require 'order'
require 'ap'
require 'date'

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
    qdate = get_date
    date = Date.new( qdate.year, qdate.month, qdate.day )
    customer = get_customer
    line_items = get_line_items( customer )

    order = Order.new( customer, date, line_items )
    OrdersModel.add_order_to_model( order, @orders_model )
  end


  # Returns a Qt::Date object
  def get_date
    date_dialog = DateDialog.new(self)
    if date_dialog.exec == 1  # if user accepted the dialog
      date_dialog.get_date
    else
      Qt::Date.new
    end
  end

  def get_customer
    customer_dialog = CustomerDialog.new( @customers, self)
    if customer_dialog.exec == 1  # if user accepted the dialog
      customer_dialog.get_customer
    else
      String.new
    end
  end

  def get_line_items( customer )
    line_items_dialog = LineItemsDialog.new( @products, customer, self )
    if line_items_dialog.exec == 1
      line_items_dialog.get_line_items
    else
      Array.new
    end
  end

end