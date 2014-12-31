require 'date_dialog'
require 'customer_dialog'

class OrdersTab < Qt::Widget

  slots 'new_order()'

  def initialize( customers_model, orders_model, parent = nil )
    super(parent)

    @customers_model = customers_model

    button = Qt::PushButton.new( tr( 'Nova comanda' ) )
    orders_tree_view = Qt::TreeView.new
    orders_tree_view.model = orders_model
    orders_tree_view.windowTitle = 'Orders Tree Model'
    orders_tree_view.show

    self.layout = Qt::VBoxLayout.new do |m|
      m.addWidget( button )
      m.addWidget( orders_tree_view )

      # Add spacer
      #m.addStretch( 1 )
    end

    connect( button, SIGNAL( 'clicked()' ), self, SLOT( 'new_order()' ) )

  end

  def new_order
    date = get_date
    customer = get_customer
    #line_items = get_line_items
  end

  def get_date
    date_dialog = DateDialog.new(self)
    if date_dialog.exec == 1  # if user accepted the dialog
      Qt::MessageBox::information( self, tr( 'foo' ), "Returned #{date_dialog.get_date.toString}")

      date_dialog.get_date
    else
      Qt::Date.new
    end
  end

  def get_customer
    customer_dialog = CustomerDialog.new( @customers_model, self)
    if customer_dialog.exec == 1  # if user accepted the dialog
      Qt::MessageBox::information( self, tr( 'foo' ), "Returned #{customer_dialog.get_customer_name}")
    end
  end

end